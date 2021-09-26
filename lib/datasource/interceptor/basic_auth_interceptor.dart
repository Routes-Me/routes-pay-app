import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:localstorage/localstorage.dart';
import 'package:routes_pay/exception/app_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasicAuthInterceptor extends InterceptorContract {
  BuildContext context;
  BasicAuthInterceptor(this.context);
  @override
  Future<RequestData> interceptRequest({RequestData? data}) async {
    SharedPreferences accessToken = await SharedPreferences.getInstance();
    data!.headers["Authorization"] = accessToken.getString('token')!;
    //data.headers["CountryCode"] = "";
    //data.headers["AppVersion"] = "";
    data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    data.headers["application"] = "screen";
    print(data.toString());
    return data;
  }
  @override
  Future<ResponseData> interceptResponse({ResponseData? data}) async {
    print(data.toString());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final isLogin = (preferences.getBool('isLogin') == null) ? false : preferences.getBool('isLogin');
    switch (data!.statusCode) {
      case 401:
          if (isLogin!){
            Navigator.pushNamedAndRemoveUntil(
                context, "/renewal", (Route<dynamic> route) => false);
          }else{
            throw UnauthorisedException("Wrong Email id and password");
          }
        break;
      default:
    }
    return data;
  }
}
