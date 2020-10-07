part of 'nepal_stats_bloc.dart';

@immutable
abstract class NepalStatsState {
  const NepalStatsState();
}

class InitialNepalStatsState extends NepalStatsState {
  const InitialNepalStatsState();
}

class LoadingNepalStatsState extends NepalStatsState {
  const LoadingNepalStatsState();
}

class LoadedNepalStatsState extends NepalStatsState {
  final NepalStats nepalStats;

  const LoadedNepalStatsState({
    @required this.nepalStats,
  }) : assert(nepalStats != null);
}

class ErrorNepalStatsState extends NepalStatsState {
  final String message;

  const ErrorNepalStatsState({
    @required this.message,
  }) : assert(message != null);
}
