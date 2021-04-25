import 'package:flutter/material.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class RegisterViewModel extends ChangeNotifier{
  BuildContext context;
  ApiResponse _apiResponse = ApiResponse.initial('Loading From Model');
  final userRepository = UserRepository();
  ApiResponse get response => _apiResponse;

  Future<void> signIn(Map<String, String> params, BuildContext context) async {
    try {
      params = {
        "Email" : 'test32@gmail.com',
        "PhoneNumber" : '4702232891',
        "Password" : 'BsF6knjxmpt86770t2LMCWX9O+GKQWzMtABrSnYN3gw==',
        "Name" : 'Rohit Yadav'
      };
      String userItem = await userRepository.register(params, context);
      setState(ApiResponse.completed(userItem));
    } catch (e) {

      setState(ApiResponse.error(e.toString()));
    }
    notifyListeners();
  }

  void setState(ApiResponse apiResponse) {
    _apiResponse = apiResponse;
    notifyListeners();
  }

}