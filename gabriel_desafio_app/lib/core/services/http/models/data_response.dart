// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataResponse {
  final List<Map<String, dynamic>> data;
  final Status status;

  DataResponse({
    required this.data,
    required this.status,
  });

  factory DataResponse.fromMap(Map<String, dynamic> map) {
    return DataResponse(
      data: List<Map<String, dynamic>>.from(map['data']),
      status: Status.fromMap(map['status'] as Map<String, dynamic>),
    );
  }

  factory DataResponse.fromJson(String source) =>
      DataResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Status {
  final String? message;
  final int code;

  Status({
    required this.message,
    required this.code,
  });

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      message: map['message'] != null ? map['message'] as String : null,
      code: map['code'] as int,
    );
  }

  factory Status.fromJson(String source) =>
      Status.fromMap(json.decode(source) as Map<String, dynamic>);
}
