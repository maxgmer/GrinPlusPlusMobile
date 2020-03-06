import 'package:equatable/equatable.dart';

class SeedScreenState extends Equatable {
  final bool warningAcknowledged;
  final bool verifyingSeedPhrase;
  final bool createdSuccessfully;
  final List<String> seed;
  final List<String> obfuscatedSeed;

  SeedScreenState({
    this.warningAcknowledged,
    this.verifyingSeedPhrase,
    this.createdSuccessfully,
    this.seed,
    this.obfuscatedSeed,
  });

  factory SeedScreenState.initial() {
    return SeedScreenState(
      warningAcknowledged: false,
      verifyingSeedPhrase: false,
      createdSuccessfully: false,
    );
  }

  SeedScreenState copyWith({bool warningAcknowledged, bool verifyingSeedPhrase,
    bool createdSuccessfully, List<String> seed, List<String> obfuscatedSeed}) {
    return SeedScreenState(
      warningAcknowledged: warningAcknowledged ?? this.warningAcknowledged,
      verifyingSeedPhrase: verifyingSeedPhrase ?? this.verifyingSeedPhrase,
      seed: seed ?? this.seed,
      obfuscatedSeed: obfuscatedSeed ?? this.obfuscatedSeed,
      createdSuccessfully: createdSuccessfully ?? this.createdSuccessfully,
    );
  }

  @override
  List<Object> get props => [
    warningAcknowledged,
    verifyingSeedPhrase,
    createdSuccessfully,
    seed,
    obfuscatedSeed,
  ];
}