part of 'nepal_district_bloc.dart';

@immutable
abstract class NepalDistrictState {}

class InitialDistrictState extends NepalDistrictState {}

class LoadingDistrictState extends NepalDistrictState {}

class LoadedDistrictState extends NepalDistrictState {
  final List<District> allDistricts;
  final List<District> searchedDistricts;

  bool get shouldShowAllDistricts => searchedDistricts == null;
  bool get isSearchEmpty => searchedDistricts.isEmpty;
  bool isDistrictInSearch(District d) {
    if (shouldShowAllDistricts) {
      return false;
    }
    return searchedDistricts.contains(d);
  }

  LoadedDistrictState({
    @required this.allDistricts,
    @required this.searchedDistricts,
  }) : assert(allDistricts != null);
}

class ErrorDistrictState extends NepalDistrictState {
  final String message;

  ErrorDistrictState({
    @required this.message,
  }) : assert(message != null);
}
