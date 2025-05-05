import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pricing_state.dart';

class PricingCubit extends Cubit<PricingState> {
  PricingCubit() : super(PricingInitial());
}
