part of 'due_date_cubit.dart';

@immutable
sealed class DueDateState {}

final class DueDateInitial extends DueDateState {}

final class DueDateCalculatorState extends DueDateState {
  final String selectedMethod;
  final DateTime? selectedDate;
  final DateTime? dueDate;
  final String remainingText;

  DueDateCalculatorState({
    required this.selectedMethod,
    required this.selectedDate,
    required this.dueDate,
    required this.remainingText,
  });
}
