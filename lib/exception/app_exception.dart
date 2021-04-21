class AppException implements Exception{
  Map<String,dynamic> values;
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);
  String toString() {
    return "$_message";
  }
}

class UnauthorisedException extends AppException {

  UnauthorisedException([message]) : super(message, "Unauthorised Request: ");
}