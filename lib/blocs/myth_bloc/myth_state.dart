part of 'myth_bloc.dart';

@immutable
abstract class MythState {
  const MythState();
}

class InitialMythState extends MythState {
  const InitialMythState();
}

class LoadingMythState extends MythState {
  const LoadingMythState();
}

class LoadedMythState extends MythState {
  final List<Myth> myths;

  const LoadedMythState({
    @required this.myths,
  }) : assert(myths != null);
}

class ErrorMythState extends MythState {
  final String message;

  const ErrorMythState({
    @required this.message,
  }) : assert(message != null);
}
