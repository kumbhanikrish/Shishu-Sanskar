import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shishu_sanskar/main.dart';
import 'package:shishu_sanskar/module/setting/repo/profile_repo.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileRepo profileRepo = ProfileRepo();

  Future<Response> editProfile(
    BuildContext context, {
    required String firstName,
    required String middleName,
    required String lastName,
    required String contactNumber,
    required String whatsappNumber,
    required String email,
    required String gender,
    required String marital,
    required String noOfKid,
    required String profileImage,
  }) async {
    Map<String, dynamic> editProfileParams = {
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "contact_number": contactNumber,
      "whatsapp_number": whatsappNumber,
      "email": email,
      "gender": gender,
      "marital": marital,
      "no_of_kid": noOfKid,
    };

    log('profileImage ::$profileImage');

    if (profileImage.isNotEmpty && !profileImage.startsWith('http')) {
      editProfileParams["profile_image"] = await MultipartFile.fromFile(
        profileImage,
        filename: profileImage.split('/').last,
      );
    }

    Response response = await profileRepo.editProfile(
      context,
      params: editProfileParams,
    );

    if (response.data['success'] == true) {
      await localDataSaver.getLoginModel().then((loginModel) {
        loginModel.user.firstName = response.data['data']['first_name'];
        loginModel.user.middleName = response.data['data']['middle_name'];
        loginModel.user.lastName = response.data['data']['last_name'];
        loginModel.user.contactNumber = response.data['data']['contact_number'];
        loginModel.user.whatsappNumber =
            response.data['data']['whatsapp_number'];
        loginModel.user.email = response.data['data']['email'];
        loginModel.user.gender = response.data['data']['gender'];
        loginModel.user.marital = response.data['data']['marital'];
        loginModel.user.noOfKid = int.parse(response.data['data']['no_of_kid']);

        loginModel.user.profileImage =
            response.data['data']['profile_image'] ?? ' ';

        localDataSaver.setLoginData(loginModel);
      });
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.settingScreen,
        (route) => false,
      );
    }

    return response;
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() {
    if (state > 0) emit(state - 1);
  }

  void setInitialCount(int value) => emit(value);

  init() {
    emit(0);
  }
}

class ProfileImageCubit extends Cubit<File?> {
  ProfileImageCubit() : super(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(File(image.path));
    }
  }

  void clearImage() {
    emit(null);
  }
}
