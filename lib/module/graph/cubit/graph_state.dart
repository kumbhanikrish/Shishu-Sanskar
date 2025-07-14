part of 'graph_cubit.dart';

@immutable
sealed class GraphState {}

final class GraphInitial extends GraphState {}

final class GraphReportState extends GraphState {
  final DailyReportModel dailyReportModel;
  final WeeklyReportModel weeklyReportModel;
  final MonthlyReportModel monthlyReportModel;

  GraphReportState({
    required this.dailyReportModel,
    required this.weeklyReportModel,
    required this.monthlyReportModel,
  });
}

@immutable
sealed class GraphTabState {}

final class GraphTabInitial extends GraphTabState {}

final class GraphTabLoaded extends GraphTabState {
  final int tabIndex;

  GraphTabLoaded({required this.tabIndex});
}
