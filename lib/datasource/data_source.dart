import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:routes_pay/datasource/interceptor/LoginInterceptor.dart';
import 'package:routes_pay/datasource/interceptor/expire_retry_policy.dart';
import 'package:routes_pay/exception/app_exception.dart';
import 'package:routes_pay/exception/bad_request_exception.dart';
import 'package:routes_pay/exception/fetch_data_exception.dart';
import 'package:routes_pay/ui/model/data_model.dart';
import 'base_service.dart';

class DataSource extends BaseService{
  HttpClientWithInterceptor client = HttpClientWithInterceptor.build(interceptors: [LoginInterceptor()],retryPolicy: ExpireRetryPolicy());
  @override
  Future getResponse(Map<String, String> params,String url) async {
    dynamic responseJson;
    try {
      final response = await client.get(Uri.parse(baseUrl + url));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future postResponse(Map<String, String> params,String url) async {
    dynamic responseJson;
    try {
      final response = await client.post(Uri.parse(baseUrl + url),
          body:json.encode(params)
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;

  }

  @visibleForTesting
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401 :
       throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }


}