part of 'news_bloc.dart';

@immutable
abstract class NewsState {
  const NewsState();
}

class InitialNewsState extends NewsState {
  const InitialNewsState();
}

class LoadingNewsState extends NewsState {
  const LoadingNewsState();
}

class LoadedNewsState extends NewsState {
  final List<News> news;

  const LoadedNewsState({
    @required this.news,
  }) : assert(news != null);
}

class ErrorNewsState extends NewsState {
  final String message;

  const ErrorNewsState({
    @required this.message,
  }) : assert(message != null);
}
