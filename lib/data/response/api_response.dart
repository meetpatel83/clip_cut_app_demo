import 'package:clipcut/data/response/status.dart';

class ApiResponse<T> {
  final Status status;
  final T? data;
  final String? message;

  const ApiResponse._({required this.status, this.data, this.message});

  const ApiResponse.initial() : this._(status: Status.initial);

  const ApiResponse.loading() : this._(status: Status.loading);

  const ApiResponse.completed(T data) : this._(status: Status.completed, data: data);

  const ApiResponse.error(String message) : this._(status: Status.error, message: message);

  ApiResponse.completedWithMessage(this.data, this.message) : status = Status.completed;

  @override
  String toString() {
    return "Status: $status\nMessage: $message\nData: $data";
  }
}
