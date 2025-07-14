part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetUserDataState extends ProfileState {
  final UserDataModel userDataModel;

  GetUserDataState({required this.userDataModel});
}
