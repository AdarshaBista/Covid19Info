part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class InitialCountryState extends CountryState {}

class LoadingCountryState extends CountryState {}

class LoadedCountryState extends CountryState {
  static const int MAX_CASES = 100000;
  final List<Country> countries;

  List<Country> get mostInfected => countries.where((c) => c.totalConfirmed > MAX_CASES).toList();

  LoadedCountryState({
    @required this.countries,
  }) : assert(countries != null);
}

class ErrorCountryState extends CountryState {
  final String message;

  ErrorCountryState({
    @required this.message,
  }) : assert(message != null);
}
