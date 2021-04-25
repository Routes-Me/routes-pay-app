import 'package:flutter/cupertino.dart';

abstract class BaseService {
  final String baseUrl = "https://stage.api.routesme.com/api/v1.0/";
  //final String baseUrl = "https://reqres.in/api/";

  Future<dynamic> getResponse(
      Map<String, String> params, String url, BuildContext context);

  Future<dynamic> postResponse(
      Map<String, String> params, String url, BuildContext context);
}
