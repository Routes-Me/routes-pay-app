import 'dart:io';

import 'package:http_interceptor/http_interceptor.dart';

class LoginInterceptor extends InterceptorContract{
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
    print(data.toString());
    return data;
  }


}

