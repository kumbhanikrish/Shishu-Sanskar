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
      _updateTaskStatus(response.data['data']['task_id']);
      return response;
    }
  }

  void _updateTaskStatus(int taskId) {
    void updateStatus(List<Today> list) {
      for (int i = 0; i < list.length; i++) {
        List<TodayTask> updatedTasks =
            list[i].tasks.map((task) {
              if (task.id == taskId) {
                return TodayTask(
                  id: task.id,
                  title: task.title,
                  description: task.description,
                  status: 'completed', // ✅ Update status
                  type: task.type,
                );
              }
              return task;
            }).toList();

        list[i] = Today(
          id: list[i].id,
          category: list[i].category,
          image: list[i].image,
          tasks: updatedTasks,
        );
      }
    }

    updateStatus(taskModel.today);
    updateStatus(taskModel.daily);
    updateStatus(taskModel.weekly);
  }
}
