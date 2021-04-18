import 'package:flutter/cupertino.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class LoginViewModel with ChangeNotifier{
  ApiResponse _apiResponse = ApiResponse.initial('Loading From Model');
  ApiResponse get response =>_apiResponse;

  Future <void> signIn(Map<String, String> params) async {
    try {
      User userItem = await UserRepository().signIn(params);
      setState(ApiResponse.completed(userItem));

    } catch (e) {
      setState(ApiResponse.error("Wrong Email id and Password"));
    }
    notifyListeners();
  }

  void setState(ApiResponse apiResponse){
    _apiResponse = apiResponse;
    notifyListeners();
  }

}