// ignore_for_file: avoid_print, unused_import

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../Widgets/custom_text_widget.dart';
import 'translation_key.dart';

class ApiService extends GetxService {
  static final ApiService _apiUtil = ApiService._();
  ApiService._() {
    init();
  }

  factory ApiService() {
    return _apiUtil;
  }

  late Dio dio;

  Future<void> init() async {
    // Initialize Dio
    dio = Dio();
    dio.options.baseUrl = "https://www.alrayyanprivateschools.com/api/";
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);

    // Add logger interceptor
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: true,
    ));
  }

  Future<dynamic> request<T>(
      String endPoint,
      String method, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        String contentType = "application/json",
        Function(String errorMsg)? errorDialog,
        Function(String? successMsg)? onSuccess,
        Function(String errorMsg)? errorMessage,
      }) async {
    try {
      Response response = await dio.request<T>(
        endPoint,
        data: data ?? {},
        queryParameters: queryParameters,
        options: Options(
          method: method,
          contentType: contentType,
        ),
      );

      if (response.statusCode != 200) {
        throw "${response.statusMessage}\n${response.statusCode}";
      }

      if (response.data == null) {
        throw "Empty response from server";
      }

      if (onSuccess != null) {
        print('✅ ApiService.request: ${response.statusMessage}');
        onSuccess(response.statusMessage);
      }

      return response.data;
    } catch (e) {
      print("❌ Error: $e");
      if (errorDialog == null && errorMessage == null) {
        await Get.defaultDialog(
          title: error.tr,
          content: CustomText(error.tr),
          middleText: "",
        );
      }
      if (errorDialog != null) {
        await errorDialog(e.toString());
      }
      if (errorMessage != null) {
        errorMessage(e.toString());
      }
      return null;
    }
  }
}