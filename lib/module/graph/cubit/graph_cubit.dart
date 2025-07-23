import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shishu_sanskar/module/graph/model/daily_report_model.dart';
import 'package:shishu_sanskar/module/graph/model/monthly_report_model.dart';
import 'package:shishu_sanskar/module/graph/model/weekly_report_model.dart';
import 'package:shishu_sanskar/module/graph/repo/graph_repo.dart';

part 'graph_state.dart';

class GraphCubit extends Cubit<GraphState> {
  GraphCubit() : super(GraphInitial());

  GraphRepo graphRepo = GraphRepo();

  DailyReportModel dailyReportModel = DailyReportModel(
    data: DailyData(
      tasks: 0,
      completedTasks: 0,
      pendingTasks: 0,
      currentSubscriptionDay: 0,
    ),
    completedTasksList: [],
  );
  WeeklyReportModel weeklyReportModel = WeeklyReportModel(
    data: WeeklyData(
      tuesday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      wednesday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      thursday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      friday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      saturday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      sunday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
      monday: Day(tasks: 0, completedTasks: 0, pendingTasks: 0),
    ),
    completedTasksList: [],
  );

  MonthlyReportModel monthlyReportModel = MonthlyReportModel(
    data: {},
    completedTasksList: [],
  );

  getDailyReport(BuildContext context, {required String date}) async {
    Map<String, dynamic> params = {"date": date};
    Response response = await graphRepo.getReport(
      context,
      type: 'daily',
      params: params,
    );

    if (state is GraphReportState) {
      weeklyReportModel = (state as GraphReportState).weeklyReportModel;
      monthlyReportModel = (state as GraphReportState).monthlyReportModel;
    }

    if (response.data['success'] == true) {
      final data = response.data['data'];

      dailyReportModel = DailyReportModel.fromJson(data);
    }

    emit(
      GraphReportState(
        dailyReportModel: dailyReportModel,
        weeklyReportModel: weeklyReportModel,
        monthlyReportModel: monthlyReportModel,
      ),
    );
  }

  getWeeklyReport(
    BuildContext context, {
    required String startDate,
    required String endDate,
  }) async {
    Map<String, dynamic> params = {
      "start_date": startDate,
      "end_date": endDate,
    };
    Response response = await graphRepo.getReport(
      context,
      type: 'weekly',
      params: params,
    );

    if (state is GraphReportState) {
      monthlyReportModel = (state as GraphReportState).monthlyReportModel;
      dailyReportModel = (state as GraphReportState).dailyReportModel;
    }

    if (response.data['success'] == true) {
      final data = response.data['data'];

      weeklyReportModel = WeeklyReportModel.fromJson(data);
    }

    emit(
      GraphReportState(
        weeklyReportModel: weeklyReportModel,
        dailyReportModel: dailyReportModel,
        monthlyReportModel: monthlyReportModel,
      ),
    );
  }

  getMonthlyReport(BuildContext context, {required String month}) async {
    Map<String, dynamic> params = {"month": month};
    Response response = await graphRepo.getReport(
      context,
      type: 'monthly',
      params: params,
    );
    if (state is GraphReportState) {
      weeklyReportModel = (state as GraphReportState).weeklyReportModel;
      dailyReportModel = (state as GraphReportState).dailyReportModel;
    }

    if (response.data['success'] == true) {
      final data = response.data['data'];

      monthlyReportModel = MonthlyReportModel.fromJson(data);
    }

    emit(
      GraphReportState(
        weeklyReportModel: weeklyReportModel,
        dailyReportModel: dailyReportModel,
        monthlyReportModel: monthlyReportModel,
      ),
    );
  }

  void init() {
    emit(GraphInitial());
  }
}

class GraphTabCubit extends Cubit<GraphTabState> {
  GraphTabCubit() : super(GraphTabInitial());

  void changeTab(int index) {
    emit(GraphTabLoaded(tabIndex: index));
  }

  init() {
    emit(GraphTabLoaded(tabIndex: 0));
  }
}

class SelectedDateCubit extends Cubit<String> {
  SelectedDateCubit() : super(DateFormat('yyyy-MM-dd').format(DateTime.now()));

  void updateDate(String date) {
    emit(date);
  }

  void init() {
    emit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }
}
