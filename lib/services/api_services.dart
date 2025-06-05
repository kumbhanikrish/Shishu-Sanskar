import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shishu_sanskar/local_data/local_data_sever.dart';
import 'package:shishu_sanskar/utils/constant/app_page.dart';
import 'package:shishu_sanskar/utils/widgets/custom_error_toast.dart';

// Local data storage
LocalDataSaver dataSaver = LocalDataSaver();
ApiServices apiServices = ApiServices();

class ApiServices {
  final Dio dio = Dio();

  /// Build headers for all API requests
  Future<Map<String, String>> _buildHeaders() async {
    final token = await dataSaver.getAuthToken();
    return {
      "Content-device": "application/json",
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    };
  }

  /// GET Request
  Future<Response> getDynamicData(
    BuildContext context,
    String url, {
    bool showSuccessMessage = false,
  }) async {
    log("GET URL: $url");
    try {
      await EasyLoading.show();

      final response = await dio.get(
        url,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (showSuccessMessage) {
          // Show success message
          customSuccessToast(
            context,
            text: response.data['message'] ?? 'Success',
          );
        }
        return response;
      }
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return Response(requestOptions: RequestOptions());
  }

  /// POST Request

  Future postDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params, {
    bool showSuccessMessage = false,
    bool isFormData = false,
  }) async {
    log("params :: $params");
    log("Url :: $url");

    try {
      await EasyLoading.show();

      Response response = await dio.post(
        url,
        data: isFormData ? FormData.fromMap(params) : params,
        options: Options(headers: await _buildHeaders()),
      );
      log("statusCode ::${response.statusCode}");
      log("response.data :: ${response.data}");

      if (response.statusCode == 201) {
        await EasyLoading.dismiss();
        return response;
      } else if (response.statusCode == 200) {
        if (showSuccessMessage) {
          // Show success message
          customSuccessToast(
            context,
            text: response.data['message'] ?? 'Success',
          );
        }
        await EasyLoading.dismiss();
        return response;
      }
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();

      log("Error :: $e");
    }
  }

  /// DELETE Request
  Future<Response?> deleteDynamicData(
    BuildContext context,
    String url,
    Map<String, dynamic> params,
  ) async {
    log("DELETE URL: $url");
    log("Parameters: $params");

    try {
      await EasyLoading.show();

      final response = await dio.delete(
        url,
        data: params,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// POST FormData Request (e.g. file upload)
  Future<Response?> postDynamicFormData(
    BuildContext context,
    String url,
    Map<String, dynamic> body,
  ) async {
    log("POST FormData URL: $url");
    log("Form Body: $body");

    FormData formData = FormData.fromMap(body);

    try {
      await EasyLoading.show();

      final response = await dio.post(
        url,
        data: formData,
        options: Options(headers: await _buildHeaders()),
      );

      log("Status Code: ${response.statusCode}");
      log("Response Data: ${response.data}");

      await EasyLoading.dismiss();
      if (response.statusCode == 200) return response;
    } on DioException catch (e) {
      _handleDioError(context, e);
    } catch (e) {
      await EasyLoading.dismiss();
      log("Unhandled Error: $e");
    }
    return null;
  }

  /// Handles Dio errors uniformly across all methods
  void _handleDioError(BuildContext context, DioException e) async {
    await EasyLoading.dismiss();
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    log("DioException: $responseData, Status Code: $statusCode");

    // Handle 401 Unauthorized
    if (statusCode == 401) {
      await dataSaver.setAuthToken('');
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppPage.authScreen,
        (route) => false,
      );
      return;
    }

    // Extract Validation Errors
    String errorMessage = 'Something went wrong';

    if (responseData != null) {
      if (responseData['data'] != null && responseData['data'] is Map) {
        final dataErrors = responseData['data'] as Map<String, dynamic>;
        List<String> errorMessages = [];

        dataErrors.forEach((key, value) {
          if (value is List) {
            errorMessages.addAll(value.map((e) => e.toString()));
          }
        });

        if (errorMessages.isNotEmpty) {
          errorMessage = errorMessages.join('\n');
        } else if (responseData['message'] != null) {
          errorMessage = responseData['message'];
        }
      } else if (responseData['message'] != null) {
        errorMessage = responseData['message'];
      }
    }

    // Show Toast or SnackBar
    customErrorToast(context, text: errorMessage);
  }
}
