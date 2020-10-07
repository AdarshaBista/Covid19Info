part of 'district_bloc.dart';

@immutable
abstract class DistrictState {
  const DistrictState();
}

class InitialDistrictState extends DistrictState {
  const InitialDistrictState();
}

class LoadingDistrictState extends DistrictState {
  const LoadingDistrictState();
}

class LoadedDistrictState extends DistrictState {
  final bool shouldShowSearch;
  final List<District> allDistricts;
  final List<District> searchedDistricts;

  bool get shouldShowAllDistricts => searchedDistricts == null;
  bool get isSearchEmpty => searchedDistricts.isEmpty;
  bool isDistrictInSearch(District d) {
    if (shouldShowAllDistricts) return false;
    return searchedDistricts.contains(d);
  }

  const LoadedDistrictState({
    this.shouldShowSearch = true,
    @required this.allDistricts,
    @required this.searchedDistricts,
  })  : assert(allDistricts != null),
        assert(shouldShowSearch != null);
}

class ErrorDistrictState extends DistrictState {
  final String message;

  const ErrorDistrictState({
    @required this.message,
  }) : assert(message != null);
}
