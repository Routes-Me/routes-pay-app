import 'package:http_interceptor/http_interceptor.dart';

class LoginInterceptor extends InterceptorContract{
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print(data.toString());
    return data;
  }
  
}