
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/home/model/task_model.dart';
import 'package:shishu_sanskar/module/home/repo/home_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  HomeRepo homeRepo = HomeRepo();

  TaskModel taskModel = TaskModel(today: [], weekly: [], daily: []);

  getTask(BuildContext context) async {
    Response response = await homeRepo.getTasks(context);
    if (response.data['success'] == true) {
      final data = response.data['data'];

      taskModel = TaskModel.fromJson(data);
    }

    emit(GetTaskState(taskModel: taskModel));
  }

  completeTask(BuildContext context, {required int taskId}) async {
    Response response = await homeRepo.completeTask(context, taskId: taskId);
    if (response.data['success'] == true) {
      getTask(context);
      Navigator.pop(context);
      return response;
    }
  }
}
