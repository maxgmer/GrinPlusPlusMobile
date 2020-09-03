import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grin_plus_plus/api/wallet_api/responses/transfer_response.dart';
import 'package:grin_plus_plus/api/wallet_api/wallet_api.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/repositories/session_repository.dart';
import 'package:grin_plus_plus/screens/finalize_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/screens/root_screen/bloc/bloc.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/utils/data_utils.dart';
import 'package:grin_plus_plus/utils/permissions_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class FinalizeScreenBloc extends Bloc<FinalizeScreenEvent, FinalizeScreenState> {
  RootBloc rootBloc;
  WalletApi repository;

  FinalizeScreenBloc({
    this.rootBloc,
    this.repository,
  });

  @override
  FinalizeScreenState get initialState => FinalizeScreenState.initial();

  @override
  Stream<FinalizeScreenState> mapEventToState(FinalizeScreenEvent event) async* {
    if (event is MessageUpdated) {
      yield state.copyWith(message: event.message);
    }
    if (event is GrinJoin) {
      yield state.copyWith(grinJoin: event.grinJoin);
    }
    if (event is AcknowledgeTxFilePath) {
      yield initialState;
    }
    if (event is ClearResponseFileSelection) {
      yield FinalizeScreenState(file: null);
    }
    if (event is SelectTxResponseFile) {
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
    if (event is Finalize) {
      Session session = SessionRepository.currentSession;
      String slate = state.file.readAsStringSync();
      TransferResponse response = await repository.finalize(
        session.sessionToken,
        json.decode(slate),
        state.grinJoin,
      );
      if (response?.status == 'FINALIZED') {
        Directory transactionDir = await DataUtils.getTransactionsDirectory();
        String slate = json.encode(response.slate);
        String filePathAndName = '${transactionDir.path}${basename(state.file.path)}';
        if (filePathAndName.endsWith('.response')) {
          filePathAndName = filePathAndName.substring(0, filePathAndName.length - 9);
        }
        File transactionResponseFile = File('$filePathAndName.finalized');
        if (transactionResponseFile.existsSync()) {
          int additionalNameNumber = 1;
          while (transactionResponseFile.existsSync()) {
            transactionResponseFile = File('${transactionDir.path}${basename(state.file.path)} ($additionalNameNumber).finalized');
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

  FinalizeScreenState _writeSlateToFile(File transactionFile, String slate) {
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