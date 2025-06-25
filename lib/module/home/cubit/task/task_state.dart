part of 'task_cubit.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class GetTaskState extends TaskState {
  final TaskModel taskModel;

  GetTaskState({required this.taskModel});
}
