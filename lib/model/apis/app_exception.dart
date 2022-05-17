import '../../resource/app_constants.dart';

class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, AppConstants.fetchError);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, AppConstants.invalidRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, AppConstants.unauthorisedRequest);
}

class InvalidAuthenticationException extends AppException {
  InvalidAuthenticationException([message]) : super(message, AppConstants.invalidAuthentication);
}

class InternalServerException extends AppException {
  InternalServerException([message]) : super(message, AppConstants.internalServerError);
}

class ServiceUnavailableException extends AppException {
  ServiceUnavailableException([message]) : super(message, AppConstants.serviceUnavailableError);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, AppConstants.invalidInputError);
}