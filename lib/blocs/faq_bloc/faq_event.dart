part of 'faq_bloc.dart';

@immutable
abstract class FaqEvent {
  const FaqEvent();
}

class GetFaqEvent extends FaqEvent {
  const GetFaqEvent();
}
