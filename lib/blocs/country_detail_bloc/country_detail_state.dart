part of 'country_detail_bloc.dart';

@immutable
abstract class CountryDetailState {
  const CountryDetailState();
}

class InitialCountryDetailState extends CountryDetailState {
  const InitialCountryDetailState();
}

class LoadingCountryDetailState extends CountryDetailState {
  const LoadingCountryDetailState();
}

class LoadedCountryDetailState extends CountryDetailState {
  final Country country;

  const LoadedCountryDetailState({
    @required this.country,
  }) : assert(country != null);
}

class ErrorCountryDetailState extends CountryDetailState {
  final String message;

  const ErrorCountryDetailState({
    @required this.message,
  }) : assert(message != null);
}
