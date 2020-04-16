import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/transfer_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/receive_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/utils/data_utils.dart';
import 'package:grin_plus_plus/utils/permissions_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ReceiveScreenBloc extends Bloc<ReceiveScreenEvent, ReceiveScreenState> {
  RootBloc rootBloc;
  WalletApi repository;

  ReceiveScreenBloc({
    this.rootBloc,
    this.repository,
  });

  @override
  ReceiveScreenState get initialState => ReceiveScreenState.initial();

  @override
  Stream<ReceiveScreenState> mapEventToState(ReceiveScreenEvent event) async* {
    if (event is ClearFileSelection) {
      yield ReceiveScreenState(file: null);
    }
    if (event is AcknowledgeTxFilePath) {
      yield initialState;
    }
    if (event is MessageUpdated) {
      yield state.copyWith(message: event.message);
    }
    if (event is SelectTxFile) {
      PermissionStatus status = await PermissionUtils.requestStoragePermission();
      if (status == PermissionStatus.granted) {
        File file = await FilePicker.getFile();
        yield state.copyWith(file: file);
      } else {
        NotificationsRepository.showNotification(Notification(
          title: kErrorString,
          message: kStoragePermissionNotGrantedString,
          notificationType: NotificationType.failure,
        ));
      }
    }
    if (event is Receive) {
      Session session = SessionRepository.currentSession;
      String slate = this.state.file.readAsStringSync();
      TransferResponse response = await repository.receive(
        session.sessionToken,
        json.decode(slate),
        null,
        state.message,
      );
      if (response.status == 'RECEIVED') {
        Directory transactionDir = await DataUtils.getTransactionsDirectory();
        File transactionResponseFile = File('${transactionDir.path}${basename(state.file.path)}.response');
        String slate = json.encode(response.slate);
        if (transactionResponseFile.existsSync()) {
          int additionalNameNumber = 1;
          while (transactionResponseFile.existsSync()) {
            transactionResponseFile = File('${transactionDir.path}${basename(state.file.path)} ($additionalNameNumber).response');
            additionalNameNumber++;
          }
          yield _writeSlateToFile(transactionResponseFile, slate);
        } else {
          yield _writeSlateToFile(transactionResponseFile, slate);
        }
      } else {
        NotificationsRepository.showNotification(Notification(
          title: kErrorString,
          message: kCouldNotReceiveFundsString,
          notificationType: NotificationType.failure,
        ));
      }
    }
  }

  ReceiveScreenState _writeSlateToFile(File transactionFile, String slate) {
    try {
      transactionFile.writeAsStringSync(slate);
      NotificationsRepository.showNotification(Notification(
        title: kSuccessString,
        message: kSavedTxResponseString,
        notificationType: NotificationType.success,
      ));
      return state.copyWith(transactionFilePath: transactionFile.path);
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