part of 'hospital_bloc.dart';

@immutable
abstract class HospitalState {
  const HospitalState();
}

class InitialHospitalState extends HospitalState {
  const InitialHospitalState();
}

class LoadingHospitalState extends HospitalState {
  const LoadingHospitalState();
}

class LoadedHospitalState extends HospitalState {
  final List<Hospital> hospitals;

  const LoadedHospitalState({
    @required this.hospitals,
  }) : assert(hospitals != null);
}

class ErrorHospitalState extends HospitalState {
  final String message;

  const ErrorHospitalState({
    @required this.message,
  }) : assert(message != null);
}
