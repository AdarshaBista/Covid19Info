part of 'global_stats_bloc.dart';

@immutable
abstract class GlobalStatsState {}

class InitialWorldStatsState extends GlobalStatsState {}

class LoadingWorldStatsState extends GlobalStatsState {}

class LoadedWorldStatsState extends GlobalStatsState {
  final GlobalCount worldStats;

  LoadedWorldStatsState({
    @required this.worldStats,
  }) : assert(worldStats != null);
}

class ErrorWorldStatsState extends GlobalStatsState {
  final String message;

  ErrorWorldStatsState({
    @required this.message,
  }) : assert(message != null);
}
