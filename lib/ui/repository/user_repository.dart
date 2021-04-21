import 'package:flutter/material.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/data_source.dart';
import '../../datasource/base_service.dart';

class UserRepository {
  BaseService baseService = DataSource();

  Future<User> signIn(Map<String, String> params, BuildContext context) async {
    String url = "authentications";
    dynamic response = await baseService.postResponse(params, url, context);
    final jsonData = response['token'];
    print('Response $jsonData');
    //User userItem = jsonData.map((tagJson) => User.fromJson(tagJson));
    User userItem = User(token: jsonData);
    return userItem;
  }

  Future<User> renewalToken(Map<String,String> params,BuildContext context) async{
    String url = "renewal_token";
    dynamic response = await baseService.postResponse(params, url, context);
    final jsonData = response[''];

  }
}
