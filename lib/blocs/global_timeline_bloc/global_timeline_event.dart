part of 'global_timeline_bloc.dart';

@immutable
abstract class GlobalTimelineEvent {
  const GlobalTimelineEvent();
}

class GetGlobalTimelineEvent extends GlobalTimelineEvent {
  const GetGlobalTimelineEvent();
}
