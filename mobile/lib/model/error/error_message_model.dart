import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class ErrorMessageModel {
  String? title;
  String? detail;
  ErrorMessageModel({
    this.title,
    this.detail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'detail': detail,
    };
  }

  factory ErrorMessageModel.fromMap(Map<String, dynamic> map) {
    return ErrorMessageModel(
      title: map['title'] != null ? map['title'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorMessageModel.fromJson(String source) => ErrorMessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

