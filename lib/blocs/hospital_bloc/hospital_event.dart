part of 'hospital_bloc.dart';

@immutable
abstract class HospitalEvent {
  const HospitalEvent();
}

class GetHospitalsEvent extends HospitalEvent {
  const GetHospitalsEvent();
}

class SearchHospitalEvent extends HospitalEvent {
  final String searchTerm;

  const SearchHospitalEvent({
    @required this.searchTerm,
  }) : assert(searchTerm != null);
}
