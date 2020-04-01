part of 'world_stats_bloc.dart';

@immutable
abstract class WorldStatsState {}

class InitialWorldStatsState extends WorldStatsState {}

class LoadingWorldStatsState extends WorldStatsState {}

class LoadedWorldStatsState extends WorldStatsState {
  final WorldInfectionData worldStats;

  LoadedWorldStatsState({
    @required this.worldStats,
  }) : assert(worldStats != null);
}

class ErrorWorldStatsState extends WorldStatsState {
  final String message;

  ErrorWorldStatsState({
    @required this.message,
  }) : assert(message != null);
}
