class AppException implements Exception {
  String? title, body;
  AppException({required this.body, required this.title});

  String toErrorMsg() {
    return "$title : $body";
  }
}

class FetchDataException extends AppException {
  FetchDataException({required String body})
      : super(title: "Error During Communication", body: body);
}

class BadRequestException extends AppException {
  BadRequestException({required String body})
      : super(title: "Invalid Request", body: body);
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException({required String body})
      : super(title: "UnAuthorized Error", body: body);
}

class InvalidRequest extends AppException {
  InvalidRequest({required String body})
      : super(title: "Invalid Input", body: body);
}
