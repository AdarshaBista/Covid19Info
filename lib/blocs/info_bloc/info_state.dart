part of 'info_bloc.dart';

@immutable
abstract class InfoState {}

class InitialInfoState extends InfoState {}

class LoadingInfoState extends InfoState {}

class LoadedInfoState extends InfoState {
  final List<Faq> faqs;
  final List<Myth> myths;

  LoadedInfoState({
    @required this.faqs,
    @required this.myths,
  })  : assert(faqs != null),
        assert(myths != null);
}

class ErrorInfoState extends InfoState {
  final String message;

  ErrorInfoState({
    @required this.message,
  }) : assert(message != null);
}
