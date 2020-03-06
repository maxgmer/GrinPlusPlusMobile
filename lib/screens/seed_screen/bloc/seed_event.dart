import 'package:equatable/equatable.dart';

abstract class SeedScreenEvent extends Equatable {
  const SeedScreenEvent();

  @override
  List<Object> get props => [];
}

class VerifyUserSavedSeed extends SeedScreenEvent {}
class BackToSeed extends SeedScreenEvent {}
class FinishWalletCreation extends SeedScreenEvent {
  final List<String> submittedSeed;

  FinishWalletCreation(this.submittedSeed);

  @override
  List<Object> get props => [submittedSeed];
}
class AcknowledgeWarning extends SeedScreenEvent {}
class Init extends SeedScreenEvent {
  final String seed;

  Init(this.seed);

  @override
  List<Object> get props => [seed];
}