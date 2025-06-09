part of 'ovulation_calculator_cubit.dart';

@immutable
sealed class OvulationCalculatorState {}

final class OvulationCalculatorInitial extends OvulationCalculatorState {}

class OvulationCalculatorResult extends OvulationCalculatorState {
  final DateTime fertileStart;
  final DateTime fertileEnd;
  final DateTime ovulationDay;
  final DateTime nextPeriod;
  final DateTime pregnancyTestDay;
  final DateTime estimatedDueDate;

  OvulationCalculatorResult({
    required this.fertileStart,
    required this.fertileEnd,
    required this.ovulationDay,
    required this.nextPeriod,
    required this.pregnancyTestDay,
    required this.estimatedDueDate,
  });

  @override
  List<Object?> get props => [
    fertileStart,
    fertileEnd,
    ovulationDay,
    nextPeriod,
    pregnancyTestDay,
    estimatedDueDate,
  ];
}

///
sealed class SelectCalenderState {}

final class SelectCalenderInitial extends SelectCalenderState {}

class SelectCalenderValueState extends SelectCalenderState {
  final DateTime selectedDay;
  final DateTime focusedDay;

  SelectCalenderValueState({
    required this.selectedDay,
    required this.focusedDay,
  });

  @override
  List<Object?> get props => [selectedDay, focusedDay];
}
