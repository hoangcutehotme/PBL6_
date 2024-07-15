// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:app_detection_littering/model/error/error_message_model.dart';

class ErrorModel {
  List<ErrorMessageModel>? errors;
  ErrorModel({
    this.errors,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      errors: map['errors'] != null
          ? (map['errors'] as List<dynamic>).map((e) => ErrorMessageModel.fromMap(e as Map<String, dynamic>)).toList()
          : null,
    );
  }

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
