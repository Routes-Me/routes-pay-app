import 'package:flutter/cupertino.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class LoginViewModel with ChangeNotifier {
  BuildContext context;

  ApiResponse _apiResponse = ApiResponse.initial('Loading From Model');
  final userRepository = UserRepository();

  ApiResponse get response => _apiResponse;

  Future<void> signIn(Map<String, String> params, BuildContext context) async {
    try {
      User userItem = await userRepository.signIn(params, context);
      setState(ApiResponse.completed(userItem));
    } catch (e) {
      //print("Error Response ${e.toString()}");
      setState(ApiResponse.error(e.toString()));
    }
    notifyListeners();
  }

  void setState(ApiResponse apiResponse) {
    _apiResponse = apiResponse;
    notifyListeners();
  }
}
