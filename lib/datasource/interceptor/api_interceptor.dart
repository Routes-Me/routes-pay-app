import 'package:flutter/src/widgets/framework.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:routes_pay/datasource/interceptor/basic_auth_interceptor.dart';
import 'package:routes_pay/datasource/interceptor/expire_retry_policy.dart';

class ApiInterceptor{
  BuildContext context;
  HttpClientWithInterceptor client;
  ApiInterceptor(this.context){
    client = HttpClientWithInterceptor.build(interceptors: [BasicAuthInterceptor(context)],retryPolicy: ExpireRetryPolicy(context));
  }
}