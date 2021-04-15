import 'package:routes_pay/exception/app_exception.dart';

class BadRequestException extends AppException{

  BadRequestException([message]) : super(message, "Invalid Request: ");

}