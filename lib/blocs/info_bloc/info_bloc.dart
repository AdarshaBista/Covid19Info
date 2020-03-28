import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/faq.dart';
import 'package:covid19_info/core/models/myth.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'info_event.dart';
part 'info_state.dart';

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  final ApiService apiService;

  InfoBloc({
    @required this.apiService,
  }) : assert(apiService != null);

  @override
  InfoState get initialState => InitialInfoState();

  @override
  Stream<InfoState> mapEventToState(
    InfoEvent event,
  ) async* {
    if (event is GetInfoEvent) {
      yield LoadingInfoState();
      try {
        final List<Faq> faqs = await apiService.fetchFaqs(0);
        final List<Myth> myths = await apiService.fetchMyths(0);
        yield LoadedInfoState(
          faqs: faqs,
          myths: myths,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorInfoState(message: e.message);
      }
    }
  }
}
