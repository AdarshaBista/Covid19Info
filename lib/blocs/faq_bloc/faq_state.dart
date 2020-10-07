part of 'faq_bloc.dart';

@immutable
abstract class FaqState {
  const FaqState();
}

class InitialFaqState extends FaqState {
  const InitialFaqState();
}

class LoadingFaqState extends FaqState {
  const LoadingFaqState();
}

class LoadedFaqState extends FaqState {
  final List<Faq> faqs;

  const LoadedFaqState({
    @required this.faqs,
  }) : assert(faqs != null);
}

class ErrorFaqState extends FaqState {
  final String message;

  const ErrorFaqState({
    @required this.message,
  }) : assert(message != null);
}
