part of 'global_timeline_bloc.dart';

@immutable
abstract class GlobalTimelineState {
  const GlobalTimelineState();
}

class InitialGlobalTimelineState extends GlobalTimelineState {
  const InitialGlobalTimelineState();
}

class LoadingGlobalTimelineState extends GlobalTimelineState {
  const LoadingGlobalTimelineState();
}

class LoadedGlobalTimelineState extends GlobalTimelineState {
  final List<TimelineData> globalTimeline;

  const LoadedGlobalTimelineState({
    @required this.globalTimeline,
  }) : assert(globalTimeline != null);
}

class ErrorGlobalTimelineState extends GlobalTimelineState {
  final String message;

  const ErrorGlobalTimelineState({
    @required this.message,
  }) : assert(message != null);
}
