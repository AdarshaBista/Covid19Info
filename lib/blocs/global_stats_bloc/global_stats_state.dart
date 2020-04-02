part of 'global_stats_bloc.dart';

@immutable
abstract class GlobalStatsState {}

class InitialGlobalStatsState extends GlobalStatsState {}

class LoadingGlobalStatsState extends GlobalStatsState {}

class LoadedGlobalStatsState extends GlobalStatsState {
  final GlobalStats globalStats;

  LoadedGlobalStatsState({
    @required this.globalStats,
  }) : assert(globalStats != null);
}

class ErrorGlobalStatsState extends GlobalStatsState {
  final String message;

  ErrorGlobalStatsState({
    @required this.message,
  }) : assert(message != null);
}
