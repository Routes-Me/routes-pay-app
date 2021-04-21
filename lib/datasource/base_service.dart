import 'package:flutter/cupertino.dart';

abstract class BaseService {
  final String baseUrl = "https://stage.api.routesme.com/api/v1.0/";

  Future<dynamic> getResponse(
      Map<String, String> params, String url, BuildContext context);

  Future<dynamic> postResponse(
      Map<String, String> params, String url, BuildContext context);
}
