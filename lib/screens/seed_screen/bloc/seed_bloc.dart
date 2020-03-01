import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
      indicesToVerify.add(math.Random().nextInt(seed.length));
    }
    List<String> obfuscatedSeed = List.from(seed);
    for (int index in indicesToVerify) {
      obfuscatedSeed[index] = '*';
    }
    return obfuscatedSeed;
  }
}
