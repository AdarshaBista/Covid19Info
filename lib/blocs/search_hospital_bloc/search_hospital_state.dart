part of 'search_hospital_bloc.dart';

@immutable
abstract class SearchHospitalState {}

class InitialSearchHospitalState extends SearchHospitalState {}

class LoadingSearchHospitalState extends SearchHospitalState {}

class LoadedSearchHospitalState extends SearchHospitalState {
  final List<Hospital> searchedHospitals;

  LoadedSearchHospitalState({
    @required this.searchedHospitals,
  }) : assert(searchedHospitals != null);
}

class EmptySearchHospitalState extends SearchHospitalState {}
