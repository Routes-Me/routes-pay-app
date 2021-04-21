import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:routes_pay/datasource/interceptor/api_interceptor.dart';
import 'package:routes_pay/exception/bad_request_exception.dart';
import 'package:routes_pay/exception/fetch_data_exception.dart';
import 'base_service.dart';

class DataSource extends BaseService {
  HttpClientWithInterceptor client;
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
      case 500:
      default:
        throw FetchDataException(
            'Something is wrong please try again later');
    }
  }
}
