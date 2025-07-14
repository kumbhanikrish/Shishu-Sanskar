import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shishu_sanskar/module/home/model/event_model.dart';
import 'package:shishu_sanskar/module/home/repo/home_repo.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());
  int currentPage = 1;
  bool isLastPage = false;
  HomeRepo homeRepo = HomeRepo();

  List<EventModel> eventList = [];
  List<EventModel> moreEventList = [];

  getEvent(BuildContext context) async {
    currentPage = 1;
    isLastPage = false;

    emit(LoadingEventState());

    Response response = await homeRepo.getEvent(
      context,
      page: currentPage.toString(),
    );

    if (response.data['success'] == true) {
      final data = response.data['data'];
      final List newComments = data['data'] ?? [];

      eventList = newComments.map((e) => EventModel.fromJson(e)).toList();

      // Check if this is the last page
      isLastPage = data['next_page_url'] == null;

      emit(GetEventState(eventList: eventList));
    } else {
      emit(FailedLoadingEventState());
    }
  }

  loadMoreEventList(BuildContext context) async {
    if (isLastPage) return; // Prevent further API calls

    emit(LoadingEventState());

    try {
      currentPage += 1;

      final response = await homeRepo.getEvent(
        context,
        page: currentPage.toString(),
      );

      if (response.data['success'] == true) {
        final data = response.data['data'];
        final List newComments = data['data'] ?? [];

        moreEventList = newComments.map((e) => EventModel.fromJson(e)).toList();

        eventList.addAll(moreEventList);

        // Update pagination state
        isLastPage = data['next_page_url'] == null;

        emit(MoreEventListLoadedState(eventList: eventList));
      } else {
        emit(MoreEventListLoadedState(eventList: eventList));
      }
    } catch (error) {
      emit(FailedLoadingEventState());
    }
  }

  joinEvent(
    BuildContext context, {
    required int eventId,
    required bool detail,
  }) async {
    Response response = await homeRepo.joinEvent(context, eventId: eventId);
    if (response.data['success'] == true) {
      getEvent(context);
      if (detail) {
        Navigator.pop(context);
      }

      return response;
    }
  }
}
