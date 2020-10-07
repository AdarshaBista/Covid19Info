part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {
  const NewsEvent();
}

class GetNewsEvent extends NewsEvent {
  const GetNewsEvent();
}
