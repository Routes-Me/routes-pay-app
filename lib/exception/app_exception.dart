class AppException implements Exception{
  late Map<String,dynamic> values;
  late final String? _message;
  //final String?_prefix;
  /////
   AppException([this._message, ]);
  String toString() {
    return "$_message";
  }
}

class UnauthorisedException extends AppException {

  UnauthorisedException([message]) : super(message,);
}