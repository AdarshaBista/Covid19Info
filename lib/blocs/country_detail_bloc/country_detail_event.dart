part of 'country_detail_bloc.dart';

@immutable
abstract class CountryDetailEvent {
  const CountryDetailEvent();
}

class GetCountryDetailEvent extends CountryDetailEvent {
  final Country country;

  const GetCountryDetailEvent({
    @required this.country,
  }) : assert(country != null);
}
