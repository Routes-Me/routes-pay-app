import 'package:flutter/cupertino.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/api_response.dart';
import 'package:routes_pay/datasource/base_service.dart';
import 'package:routes_pay/datasource/data_source.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';

class LoginViewModel with ChangeNotifier {
  BuildContext? context;
  BaseService baseService = DataSource();

/////
  ApiResponse? _apiResponse = ApiResponse.initial('Loading From Model');
  final userRepository = UserRepository();

/////
  ApiResponse? get response => _apiResponse;

  Future<void> signIn(Map<String, String> params, BuildContext context) async {
    try {
      UserI userItem = await userRepository.signIn(params, context);
      /////
      setState(ApiResponse.completed(userItem));
    } catch (e) {
      print("Error Response ${e.toString()}");
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


  //
  Future<UserI> signInWithSocial(Map<String, String> params, BuildContext context) async {
    String url = "authentications";
    dynamic response = await baseService.postResponse(params, url, context);
    final jsonData = response['token'];
    UserI userItem = UserI(token: jsonData);
    return userItem;
  }

}
