part of 'country_bloc.dart';

@immutable
abstract class CountryState {}

class InitialCountryState extends CountryState {}

class LoadingCountryState extends CountryState {}

class LoadedCountryState extends CountryState {
  final List<Country> countries;

  List<Country> get mostInfected => countries.take(5).toList();

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
