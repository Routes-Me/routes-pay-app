import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/data/pojo/user_token.dart';
import 'package:routes_pay/datasource/data_source.dart';
import '../../datasource/base_service.dart';

class UserRepository {
  BaseService baseService = DataSource();

  Future<User> signIn(Map<String, String> params, BuildContext context) async {
    String url = "authentications";
    dynamic response = await baseService.postResponse(params, url, context);
    final jsonData = response['token'];
    User userItem = User(token: jsonData);
    return userItem;
  }

  Future<String> register(Map<String,String> params,BuildContext context) async{
    String url = "routes-pay-app";
    dynamic response = await baseService.postResponse(params, url, context);
    final jsonData = response;
    return jsonData;
  }

  Future<UserToken> renewalToken(Map<String,String> params,BuildContext context) async{
    String url = "renewal_token";
    dynamic response = await baseService.postResponse(params, url, context);
    final refreshToken = response['refreshToken'];
    final accessToken = response['accessToken'];
    UserToken  userToken = UserToken(refreshToken:refreshToken,accessToken : accessToken);
    return userToken;
  }


}
