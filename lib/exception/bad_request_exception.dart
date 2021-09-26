import 'package:routes_pay/exception/app_exception.dart';

class BadRequestException extends AppException{

  BadRequestException([statusCode,message]) : super(message, );

}