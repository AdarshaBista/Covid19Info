part of 'municipality_bloc.dart';

@immutable
abstract class MunicipalityState {
  const MunicipalityState();
}

class InitialMunicipalityState extends MunicipalityState {
  const InitialMunicipalityState();
}

class LoadingMunicipalityState extends MunicipalityState {
  const LoadingMunicipalityState();
}

class LoadedMunicipalityState extends MunicipalityState {
  final List<Municipality> municipalities;

  const LoadedMunicipalityState({
    @required this.municipalities,
  }) : assert(municipalities != null);
}

class ErrorMunicipalityState extends MunicipalityState {
  final String message;

  const ErrorMunicipalityState({
    @required this.message,
  }) : assert(message != null);
}
