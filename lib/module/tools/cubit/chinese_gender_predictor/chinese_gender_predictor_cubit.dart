import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chinese_gender_predictor_state.dart';

class ChineseGenderPredictorCubit extends Cubit<ChineseGenderPredictorState> {
  ChineseGenderPredictorCubit() : super(ChineseGenderPredictorInitial());

  void predictGender(DateTime dob, DateTime conception) {
    const genderChart = {
      18: ["F", "M", "F", "M", "M", "M", "M", "M", "M", "M", "M", "M"],
      19: ["M", "F", "M", "F", "F", "F", "F", "F", "F", "F", "F", "F"],
      20: ["F", "M", "F", "M", "M", "M", "M", "M", "M", "F", "M", "M"],
      21: ["M", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F"],
      22: ["F", "M", "M", "F", "M", "F", "F", "M", "F", "F", "M", "F"],
      23: ["M", "M", "F", "M", "F", "M", "M", "F", "M", "M", "F", "M"],
      24: ["M", "F", "F", "M", "M", "F", "M", "F", "M", "M", "F", "M"],
      25: ["F", "M", "F", "M", "F", "M", "F", "M", "F", "M", "M", "M"],
      26: ["F", "F", "M", "F", "F", "F", "M", "F", "F", "F", "F", "F"],
      27: ["F", "F", "M", "M", "F", "F", "F", "M", "F", "M", "M", "M"],
      28: ["M", "M", "M", "F", "F", "F", "F", "F", "F", "F", "F", "F"],
      29: ["F", "M", "F", "M", "M", "M", "M", "M", "M", "M", "M", "M"],
      30: ["M", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F"],
      31: ["M", "M", "M", "M", "F", "F", "F", "M", "F", "M", "M", "M"],
      32: ["M", "F", "F", "M", "F", "M", "M", "F", "M", "M", "F", "M"],
      33: ["F", "M", "M", "F", "M", "F", "F", "M", "F", "F", "M", "F"],
      34: ["M", "M", "F", "F", "M", "M", "M", "F", "M", "M", "F", "M"],
      35: ["F", "F", "M", "F", "F", "F", "F", "M", "F", "F", "M", "F"],
      36: ["M", "F", "M", "M", "M", "M", "M", "F", "M", "M", "F", "M"],
      37: ["F", "M", "F", "F", "F", "F", "F", "M", "F", "F", "M", "F"],
      38: ["M", "M", "M", "F", "M", "M", "M", "F", "M", "M", "F", "M"],
      39: ["F", "F", "M", "F", "F", "F", "F", "M", "F", "F", "M", "F"],
      40: ["M", "M", "F", "M", "M", "M", "M", "F", "M", "M", "F", "M"],
      41: ["F", "F", "M", "F", "F", "F", "F", "M", "F", "F", "M", "F"],
      42: ["M", "F", "F", "M", "M", "F", "M", "F", "M", "M", "F", "M"],
      43: ["F", "M", "F", "F", "F", "M", "M", "M", "F", "F", "M", "F"],
      44: ["M", "F", "M", "M", "F", "F", "F", "F", "M", "M", "F", "M"],
      45: ["F", "M", "F", "F", "M", "F", "F", "M", "F", "F", "M", "F"],
    };

    int age = conception.year - dob.year;
    if (conception.month < dob.month ||
        (conception.month == dob.month && conception.day < dob.day)) {
      age--;
    }

    int month = conception.month - 1;
    final chart = genderChart[age];
    if (chart != null && chart.length > month) {
      final gender = chart[month] == "M" ? "Boy" : "Girl";
      final result = "Congratulations!!! It's a $gender.";
      emit(
        ChineseGenderPredictorCalculatorState(
          resultShot: gender,
          result: result,
        ),
      );
    } else {
      emit(
        ChineseGenderPredictorCalculatorState(
          resultShot: "",
          result: "Sorry, age not supported for prediction.",
        ),
      );
    }
  }

  init() {
    emit(ChineseGenderPredictorInitial());
  }
}
