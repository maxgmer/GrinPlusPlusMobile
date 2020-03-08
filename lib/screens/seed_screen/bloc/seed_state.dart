import 'package:equatable/equatable.dart';

class SeedScreenState extends Equatable {
  final bool warningAcknowledged;
  final bool verifyingSeedPhrase;
  final List<String> seed;
  final List<String> obfuscatedSeed;

  SeedScreenState({
    this.warningAcknowledged,
    this.verifyingSeedPhrase,
    this.seed,
    this.obfuscatedSeed,
  });

  factory SeedScreenState.initial() {
    return SeedScreenState(
      warningAcknowledged: false,
      verifyingSeedPhrase: false,
    );
  }

  SeedScreenState copyWith({bool warningAcknowledged, bool verifyingSeedPhrase,
    List<String> seed, List<String> obfuscatedSeed}) {
    return SeedScreenState(
      warningAcknowledged: warningAcknowledged ?? this.warningAcknowledged,
      verifyingSeedPhrase: verifyingSeedPhrase ?? this.verifyingSeedPhrase,
      seed: seed ?? this.seed,
      obfuscatedSeed: obfuscatedSeed ?? this.obfuscatedSeed,
    );
  }

  @override
  List<Object> get props => [
    warningAcknowledged,
    verifyingSeedPhrase,
    seed,
    obfuscatedSeed,
  ];
}