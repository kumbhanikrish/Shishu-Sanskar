part of 'event_cubit.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

class LoadingEventState extends EventState {}

class FailedLoadingEventState extends EventState {}

final class GetEventState extends EventState {
  final List<EventModel> eventList;

  GetEventState({required this.eventList});
}

class MoreEventListLoadedState extends EventState {
  final List<EventModel> eventList;

  MoreEventListLoadedState({required this.eventList});
}
