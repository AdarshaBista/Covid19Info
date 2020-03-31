part of 'search_hospital_bloc.dart';

@immutable
abstract class SearchHospitalEvent {}

class StartHospitalSearchEvent extends SearchHospitalEvent {
  final String searchTerm;

  StartHospitalSearchEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}
