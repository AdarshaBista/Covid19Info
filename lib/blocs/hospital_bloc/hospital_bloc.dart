import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/hospital.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final ApiService apiService;

  HospitalBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  HospitalState get initialState => InitialHospitalState();

  @override
  Stream<HospitalState> mapEventToState(
    HospitalEvent event,
  ) async* {
    if (event is GetHospitalEvent) {
      yield LoadingHospitalState();
      try {
        List<Hospital> hospitals = await apiService.fetchHospitals(0);
        yield LoadedHospitalState(
          hospitals: hospitals,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorHospitalState(message: e.message);
      }
    }
  }
}
