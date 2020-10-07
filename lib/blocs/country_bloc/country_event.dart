part of 'country_bloc.dart';

@immutable
abstract class CountryEvent {
  const CountryEvent();
}

class GetCountriesEvent extends CountryEvent {}

class SearchCountryEvent extends CountryEvent {
  final String searchTerm;

  const SearchCountryEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}

class FilterCountriesEvent extends CountryEvent {
  final CountryFilterType filterType;

  const FilterCountriesEvent({
    @required this.filterType,
  }) : assert(filterType != null);
}
