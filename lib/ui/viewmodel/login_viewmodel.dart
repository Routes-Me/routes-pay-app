import 'package:flutter/cupertino.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/ui/model/data_model.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier{

  //Statemanagement of viewmodel
  ApiResponse _apiResponse = ApiResponse.loading('Loading Data');

  User _user;

  ApiResponse get response {
    return _apiResponse;
  }

  User get user {
    return _user;
  }

  Future<void> signIn(SignInModel model) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    notifyListeners();
    try {
      User userItem = await UserRepository().signIn(model);
      _apiResponse = ApiResponse.completed(userItem);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }



}