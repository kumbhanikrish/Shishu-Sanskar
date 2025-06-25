import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
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
}
