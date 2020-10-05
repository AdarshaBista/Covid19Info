import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:covid19_info/core/models/faq.dart';
import 'package:covid19_info/core/models/app_error.dart';

import 'package:covid19_info/core/services/api_service.dart';

part 'faq_event.dart';
part 'faq_state.dart';

class FaqBloc extends Bloc<FaqEvent, FaqState> {
  final ApiService apiService;

  FaqBloc({
    @required this.apiService,
  })  : assert(apiService != null),
        super(InitialFaqState());

  @override
  Stream<FaqState> mapEventToState(
    FaqEvent event,
  ) async* {
    if (event is GetFaqEvent) {
      yield LoadingFaqState();
      try {
        final List<Faq> faqs = await apiService.fetchFaqs(0);
        yield LoadedFaqState(
          faqs: faqs,
        );
      } on AppError catch (e) {
        print(e.error);
        yield ErrorFaqState(message: e.message);
      }
    }
  }
}
