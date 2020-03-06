import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grin_plus_plus/repositories/pending_notifications_repository.dart';
import 'package:grin_plus_plus/screens/seed_screen/bloc/bloc.dart';
import 'dart:math' as math;

class SeedScreenBloc extends Bloc<SeedScreenEvent, SeedScreenState> {
  @override
  SeedScreenState get initialState => SeedScreenState.initial();

  @override
  Stream<SeedScreenState> mapEventToState(SeedScreenEvent event) async* {
    if (event is AcknowledgeWarning) {
      yield state.copyWith(warningAcknowledged: true);
    }
    if (event is VerifyUserSavedSeed) {
      yield state.copyWith(verifyingSeedPhrase: true);
    }
    if (event is BackToSeed) {
      yield state.copyWith(verifyingSeedPhrase: false);
    }
    if (event is FinishWalletCreation) {
      bool walletCreationSuccessful = true;
      for (int i = 0; i < event.submittedSeed.length; i++) {
        if (event.submittedSeed[i].trim() != state.seed[i].trim()) {
          walletCreationSuccessful = false;
          break;
        }
      }
      if (walletCreationSuccessful) {
        NotificationsRepository.showNotification(Notification(
          title: 'Success',
          message: 'Wallet created',
          notificationType: NotificationType.success,
        ));
      } else {
        NotificationsRepository.showNotification(Notification(
          title: 'Seed is not correct',
          message: 'Please verify the seed words you\'ve typed',
          notificationType: NotificationType.failure,
        ));
      }
      yield state.copyWith(createdSuccessfully: walletCreationSuccessful);
      yield initialState;
    }
    if (event is Init) {
      List<String> seed = event.seed.split(' ');
      List<String> obfuscatedSeed = _obfuscateSeed(seed);
      yield state.copyWith(
        seed: seed,
        obfuscatedSeed: obfuscatedSeed,
      );
    }
  }

  List<String> _obfuscateSeed(List<String> seed) {
    int numberOfWordsToVerify = int.parse(DotEnv().env['HIDDEN_SEED_WORDS_NUMBER']);
    List<int> indicesToVerify = [];
    for (int i = 0; i < numberOfWordsToVerify; i++) {
      int nextIndex = math.Random().nextInt(seed.length);
      if (indicesToVerify.contains(nextIndex)) {
        i--;
      } else {
        indicesToVerify.add(nextIndex);
      }
    }
    List<String> obfuscatedSeed = List.from(seed);
    for (int index in indicesToVerify) {
      obfuscatedSeed[index] = '';
    }
    return obfuscatedSeed;
  }
}
