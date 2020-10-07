part of 'district_bloc.dart';

@immutable
abstract class DistrictEvent {
  const DistrictEvent();
}

class GetDistrictsEvent extends DistrictEvent {
  const GetDistrictsEvent();
}

class SearchDistrictEvent extends DistrictEvent {
  final String searchTerm;

  const SearchDistrictEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}
