part of 'graph_cubit.dart';

@immutable
sealed class GraphState {}

final class GraphInitial extends GraphState {}

@immutable
sealed class GraphTabState {}

final class GraphTabInitial extends GraphTabState {}

final class GraphTabLoaded extends GraphTabState {
  final int tabIndex;

  GraphTabLoaded({required this.tabIndex});
}
