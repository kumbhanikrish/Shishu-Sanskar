import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ovulation_calculator_state.dart';

class OvulationCalculatorCubit extends Cubit<OvulationCalculatorState> {
  OvulationCalculatorCubit() : super(OvulationCalculatorInitial());
  DateTime? selectedDay;
  DateTime focusedDay = DateTime.now();
  void calculateOvulation({
    required DateTime periodStart,
    required int cycleLength,
  }) {
    log('periodStart ::$periodStart');
    final ovulationDay = periodStart.add(Duration(days: cycleLength - 14));
    final fertileStart = ovulationDay.subtract(const Duration(days: 5));
    final fertileEnd = ovulationDay;
    final nextPeriod = periodStart.add(Duration(days: cycleLength));
    final pregnancyTestDay = ovulationDay.add(const Duration(days: 15));
    final estimatedDueDate = ovulationDay.add(const Duration(days: 266));

    emit(
      OvulationCalculatorResult(
        fertileStart: fertileStart,
        fertileEnd: fertileEnd,
        ovulationDay: ovulationDay,
        nextPeriod: nextPeriod,
        pregnancyTestDay: pregnancyTestDay,
        estimatedDueDate: estimatedDueDate,
      ),
    );
  }

  init() {
    emit(OvulationCalculatorInitial());
  }
}

class SelectCalenderCubit extends Cubit<SelectCalenderState> {
  SelectCalenderCubit() : super(SelectCalenderInitial());

  void updateSelectedDay(DateTime selected, DateTime focused) {
    emit(SelectCalenderValueState(selectedDay: selected, focusedDay: focused));
  }

  init() {
    emit(SelectCalenderInitial());
  }
}

class SelectCycleCubit extends Cubit<String> {
  SelectCycleCubit() : super('28');

  updateValue({required String cycleValue}) {
    emit(cycleValue);
  }

  init() {
    emit('28');
  }
}
