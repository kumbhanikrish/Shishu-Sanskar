import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'due_date_state.dart';

class DueDateCubit extends Cubit<DueDateState> {
  DueDateCubit()
    : super(
        DueDateCalculatorState(
          selectedMethod: 'First day of my last period',
          selectedDate: null,
          dueDate: null,
          remainingText: '',
        ),
      );

  void changeMethod(String method) {
    emit(
      DueDateCalculatorState(
        selectedMethod: method,
        selectedDate: null,
        dueDate: null,
        remainingText: '',
      ),
    );
  }

  void selectDate(DateTime date) {
    final current = state as DueDateCalculatorState;

    emit(
      DueDateCalculatorState(
        selectedMethod: current.selectedMethod,
        selectedDate: date,
        dueDate: current.dueDate,
        remainingText: current.remainingText,
      ),
    );
  }

  void calculateDueDate() {
    final current = state as DueDateCalculatorState;
    if (current.selectedDate == null) return;

    final baseDate = current.selectedDate!;
    final dueDate =
        current.selectedMethod == 'First day of my last period'
            ? baseDate.add(const Duration(days: 280))
            : baseDate.add(const Duration(days: 266));

    final now = DateTime.now();
    final difference = dueDate.difference(now);
    final weeks = difference.inDays ~/ 7;
    final days = difference.inDays % 7;

    final remainingText =
        "Only $weeks Weeks${days > 0 ? " $days Days" : ""} left until your baby is born!";

    emit(
      DueDateCalculatorState(
        selectedMethod: current.selectedMethod,
        selectedDate: current.selectedDate,
        dueDate: dueDate,
        remainingText: remainingText,
      ),
    );
  }

  init() {
    emit(
      DueDateCalculatorState(
        selectedMethod: 'First day of my last period',
        selectedDate: null,
        dueDate: null,
        remainingText: '',
      ),
    );
  }
}
