part of 'pricing_cubit.dart';

@immutable
sealed class PricingState {}

final class PricingInitial extends PricingState {}

final class GetPricingState extends PricingState {
  final List<PricingModel> pricingList;

  GetPricingState({required this.pricingList});
}
