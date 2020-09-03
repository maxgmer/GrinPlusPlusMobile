import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/estimate_fee_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/foreign_receive_response.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/transfer_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/models/selection_strategy.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/send_screen/transport_type.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/utils/data_utils.dart';
import 'package:grin_plus_plus/utils/permissions_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:validators/validators.dart';
import 'bloc.dart';

class SendScreenBloc extends Bloc<SendScreenEvent, SendScreenState> {
  RootBloc rootBloc;
  WalletApi repository;

  SendScreenBloc({
    this.rootBloc,
    this.repository,
  });

  @override
  SendScreenState get initialState => SendScreenState.initial();

  @override
  Stream<SendScreenState> mapEventToState(SendScreenEvent event) async* {
    if (event is ChangeTransportType) {
      yield state.copyWith(transportType: event.transportType);
    }
    if (event is AcknowledgeTxFilePath) {
      yield initialState;
    }
    if (event is GrinJoin) {
      yield state.copyWith(grinJoin: event.grinJoinEnabled);
    }
    if (event is Send) {
      Session session = SessionRepository.currentSession;
      if (state.transportType == TransportType.file) {
        PermissionStatus status = await PermissionUtils.requestStoragePermission();
        if (status == PermissionStatus.granted) {
          SendScreenState state = await _sendViaFile(session, event);
          yield state;
        } else {
          NotificationsRepository.showNotification(Notification(
            title: kErrorString,
            message: kStoragePermissionNotGrantedString,
            notificationType: NotificationType.failure,
          ));
        }
      } else if (state.transportType == TransportType.http) {
        if (isURL(event.address, requireTld: false)) {
          yield state.copyWith(sendingInProgress: true);
          await _sendViaHttp(session, event);
          yield state.copyWith(sendingInProgress: false);
        }
      } else if (state.transportType == TransportType.tor) {

      } else {
        NotificationsRepository.showNotification(Notification(
          title: kErrorString,
          message: kTransportNotSupportedString,
          notificationType: NotificationType.failure,
        ));
      }
    }
    if (event is AddressChanged) {
      if (state.transportType == TransportType.file) {
        yield state.copyWith(
          addressError: '',
        );
      } else {
        if (!isURL(event.address, requireTld: false) &&
            event.address.isNotEmpty) {
          yield state.copyWith(
            addressError: kAddressUrlInvalidString,
          );
        } else {
          yield state.copyWith(addressError: '');
        }
      }
    }
    if (event is AmountChanged) {
      Session session = SessionRepository.currentSession;
      EstimateFeeResponse response = await repository.estimateFee(
        session.sessionToken,
        ((event.amount ?? 0) * pow(10, 9)).round(),
        SelectionStrategy.smallest,
        [],
      );
      if (response.errorMessage == null) {
        if (event.amount == null || event.amount == 0) {
          yield state.copyWith(
            amountError: 'Amount cannot be 0',
            estimatedFee: 0,
          );
        } else {
          yield state.copyWith(
            amountError: '',
            estimatedFee: response.fee / pow(10, 9),
          );
        }
      } else {
        yield state.copyWith(
          amountError: response.errorMessage,
          estimatedFee: 0,
        );
      }
    }
  }

  Future<SendScreenState> _sendViaFile(Session session, Send event) async {
    TransferResponse response = await repository.send(
      session.sessionToken,
      (event.amount * pow(10, 9)).round(),
      SelectionStrategy.smallest,
      null,
      event.message,
      state.grinJoin,
    );
    if (response?.status == 'SENT') {
      Directory transactionDir = await DataUtils.getTransactionsDirectory();
      File transactionFile = File('${transactionDir.path}${event.address}.tx');
      String slate = json.encode(response.slate);
      if (transactionFile.existsSync()) {
        int additionalNameNumber = 1;
        while (transactionFile.existsSync()) {
          transactionFile = File('${transactionDir.path}${event.address} ($additionalNameNumber).tx');
          additionalNameNumber++;
        }
        return _writeSlateToFile(transactionFile, slate);
      } else {
        return _writeSlateToFile(transactionFile, slate);
      }
    } else {
      NotificationsRepository.showNotification(Notification(
        title: kErrorString,
        message: kCouldNotSendFundsString,
        notificationType: NotificationType.failure,
      ));
    }
    return this.state;
  }

  Future _sendViaHttp(Session session, Send event) async {
    TransferResponse response = await repository.send(
      session.sessionToken,
      (event.amount * pow(10, 9)).round(),
      SelectionStrategy.smallest,
      event.address,
      event.message,
      state.grinJoin,
    );
    if (response?.status == 'SENT') {
      ForeignReceiveResponse foreignResponse = await repository.foreignReceive(
        event.address,
        response.slate,
      );
      if (foreignResponse.isSuccess) {
        TransferResponse response = await repository.finalize(
          session.sessionToken,
          foreignResponse.slate,
          state.grinJoin,
        );
        if (response?.status == 'FINALIZED') {
          NotificationsRepository.showNotification(Notification(
            title: kSuccessString,
            message: kSuccessfullySentString,
            notificationType: NotificationType.success,
          ));
          return;
        }
      }
      NotificationsRepository.showNotification(Notification(
        title: kErrorString,
        message: kCouldNotSendFundsString,
        notificationType: NotificationType.failure,
      ));
    }
  }

  SendScreenState _writeSlateToFile(File transactionFile, String slate) {
    try {
      transactionFile.writeAsStringSync(slate);
      NotificationsRepository.showNotification(Notification(
        title: kSuccessString,
        message: kSavedTxString,
        notificationType: NotificationType.success,
      ));
      return state.copyWith(
        transactionFilePath: transactionFile.path,
      );
    } catch (error) {
      print('Exception occured during write: ${error.toString()}');
      if (transactionFile.existsSync()) {
        transactionFile.deleteSync();
      }
      NotificationsRepository.showNotification(Notification(
        title: kErrorString,
        message: '${error.toString()}',
        notificationType: NotificationType.failure,
      ));
    }
    return this.state;
  }
}