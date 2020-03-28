part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class InitialNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  final List<News> news;

  LoadedNewsState({
    @required this.news,
  }) : assert(news != null);
}

class ErrorlNewsState extends NewsState {
  final String message;

  ErrorlNewsState({
    @required this.message,
  }) : assert(message != null);
}
