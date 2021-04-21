import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:localstorage/localstorage.dart';
import 'package:routes_pay/exception/app_exception.dart';

class BasicAuthInterceptor extends InterceptorContract {
  BuildContext context;
  BasicAuthInterceptor(this.context);
  final isLogin = false;
  final LocalStorage storage = new LocalStorage('isLogin');

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers["Authorization"] = "";
    data.headers["CountryCode"] = "";
    data.headers["AppVersion"] = "";
    data.headers[HttpHeaders.contentTypeHeader] = "application/json";
    data.headers["application"] = "screen";
    print(data.toString());
    return data;
  }
  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {

    switch (data.statusCode) {
      case 401:
        Future.delayed(Duration(seconds: 5), () {
          //Redirect to renewal token page if user is already login
          if (isLogin){
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (Route<dynamic> route) => false);
          }else{
            UnauthorisedException("Wrong Email id and password");
          }
        });
        break;
      default:
    }
    return data;
  }
}
