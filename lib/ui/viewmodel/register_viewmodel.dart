import 'package:flutter/material.dart';
import 'package:routes_pay/data/pojo/message.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class RegisterViewModel extends ChangeNotifier{
  BuildContext? context;
  /////
   ApiResponse _apiResponse = ApiResponse.initial('Loading From Model');
  final userRepository = UserRepository();
  /////
   ApiResponse get response => _apiResponse;
  Future<void> register(Map<String, String> params, BuildContext context) async {
    try {
      Message message = await userRepository.register(params, context);
      print("Response 1 ${message.message}");
      /////
       setState(ApiResponse.completed(message.message));
    } catch (e) {
      print("Response 2 ${e.toString()}");
     /////
       setState(ApiResponse.error(e.toString()));
    }
    notifyListeners();
  }

  void setState(ApiResponse apiResponse) {
    /////
     _apiResponse = apiResponse;
    notifyListeners();
  }

}