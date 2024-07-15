import 'dart:io';

import 'package:app_detection_littering/data/data_source/dio/dio_client.dart';
import 'package:app_detection_littering/data/data_source/exception/api_error_handler.dart';
import 'package:app_detection_littering/data/domain/end_points.dart';
import 'package:app_detection_littering/model/base/api_response.dart';
import 'package:app_detection_littering/model/base/izi_validate.dart';
import 'package:app_detection_littering/model/detection_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';

class DetectionRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  Future<void> get({
    String? filter,
    Map<String, dynamic>? queryParameters,
    required Function(List<Detection> event, int totalPage) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      response = await dioClient!.get('${EndPoints.detection}${filter ?? ''}',
          queryParameters: queryParameters);
    } catch (e) {
      print(e);
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)));
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data['data'] as List<dynamic>;
      final totalPage = response.data['total_page'] as int;
      print(results);
      onSuccess(
          results
              .map((e) => Detection.fromMap(e as Map<String, dynamic>))
              .toList(),
          totalPage);
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<String> processImage({required File image}) async {
    late Response response;

    try {
      response = await dioClient!.uploadImages(
          '${EndPoints.BASE_URL}${EndPoints.process_image}',
          files: image);
    } catch (e) {
      EasyLoading.showError("Lỗi kết nối ${e}",
          duration: Duration(milliseconds: 2000));
      return '';
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data["processed_image"] as dynamic;

      return results;
    } else {
      print("Error ");
      EasyLoading.showError("Lỗi", duration: Duration(milliseconds: 2000));
      ApiErrorHandler.getMessage(response.data);

      return '';
    }
  }

  Future<void> add({
    required Detection data,
    required Function(Detection event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;

    try {
      response =
          await dioClient!.post('${EndPoints.detection}', data: data.toJson());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)));
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(Detection.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> update({
    required String id,
    required Detection data,
    required Function(Detection event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      response = await dioClient!
          .put('${EndPoints.detection}/$id', data: data.toMap());
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)).error);
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data as dynamic;
      onSuccess(Detection.fromMap(results as Map<String, dynamic>));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }

  Future<void> delete({
    String? id,
    required Function(Detection event) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    late Response response;
    try {
      response = await dioClient!.delete('${EndPoints.detection}/$id');
    } catch (e) {
      onError(ApiResponse.withError(ApiErrorHandler.getMessage(e)));
      return;
    }
    if (!IZIValidate.nullOrEmpty(response.statusCode) &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      final results = response.data as Map<String, dynamic>;
      onSuccess(Detection.fromMap(results));
    } else {
      onError(ApiErrorHandler.getMessage(response.data));
    }
  }
}
