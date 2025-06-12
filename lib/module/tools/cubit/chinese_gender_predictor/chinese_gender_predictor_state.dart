part of 'chinese_gender_predictor_cubit.dart';

@immutable
sealed class ChineseGenderPredictorState {}

final class ChineseGenderPredictorInitial extends ChineseGenderPredictorState {}

final class ChineseGenderPredictorCalculatorState
    extends ChineseGenderPredictorState {
  final String resultShot;
  final String result;

  ChineseGenderPredictorCalculatorState({
    required this.resultShot,
    required this.result,
  });
}
