import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:routes_pay/datasource/interceptor/api_interceptor.dart';
import 'package:routes_pay/exception/bad_request_exception.dart';
import 'package:routes_pay/exception/fetch_data_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_service.dart';

class DataSource extends BaseService {
  HttpClientWithInterceptor client;
  Map<String, String> headers = {};
  @override
  Future getResponse(
      Map<String, String> params, String url, BuildContext context) async {
    dynamic responseJson;
    try {
      client = ApiInterceptor(context).client;
      final response = await http.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(
      Map<String, String> params, String url, BuildContext context) async {
    dynamic responseJson;
    try {
      client = ApiInterceptor(context).client;
      final response = await client.post(Uri.parse(baseUrl + url),
          body: json.encode(params));
       await updateCookie(response);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  void updateCookie(http.Response response) async {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final List<String> cookie = rawCookie.split(';')[0].split('=');
      SharedPreferences setRefreshToken = await SharedPreferences.getInstance();
      await setRefreshToken.setString('refreshToken', cookie[1]);
    }
  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.created :
        dynamic responseJson = jsonDecode(response.body);
        //print("Response ${responseJson}");
        return responseJson;
      case HttpStatus.OK:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case HttpStatus.BAD_REQUEST:
        print(response.body);
        throw BadRequestException(response.body.toString());
      case HttpStatus.INTERNAL_SERVER_ERROR:
      default:
        throw FetchDataException(
            'Something is wrong please try again later');
    }
  }
}
