import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

class HttpResponse {
  String message;
  int statusCode;
  Exception e;

  HttpResponse(Response response) {
    message = response.body;
    statusCode = response.statusCode;
  }

  HttpResponse.fromRawData({this.statusCode, this.message});

  HttpResponse.fromError({this.e});

  bool hasError() => (e != null);

  String parseErrorMessage() {
    dynamic error = json.decode(this.message);
    return error['message'];
  }

  String singleErrorMessage() {
    if (hasError()) {
      if (e is SocketException) {
        return 'No internet';
      } else {
        return e.toString();
      }
    }
    return 'Unexpected error';
  }
}
