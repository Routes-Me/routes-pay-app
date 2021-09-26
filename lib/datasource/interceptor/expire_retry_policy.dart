import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:http_interceptor/models/retry_policy.dart';

class ExpireRetryPolicy extends RetryPolicy {
  @override
  int maxRetryAttempts = 5;
  bool isLogin = false;

  ExpireRetryPolicy(BuildContext context);

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return super.shouldAttemptRetryOnException(reason);
  }

  //@override
// Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
//   // print("Retry Policy 2${response}");
//   //You can check if you got your response after certain timeout,
//   //or if you want to retry your request based on the status code,
//   //usually this is used for refreshing your expired token but you can check for what ever you want
//   //your should write a condition here so it won't execute this code on every request
//   //for example if(response == null)
//   // a very basic solution is that you can check
//   // for internet connection, for example
//   try {
//     Future.delayed(Duration(seconds: 1), () {
//       switch(response.statusCode){
//         case HttpStatus.BAD_REQUEST :
//           return true;
//         case HttpStatus.NOT_ACCEPTABLE :
//           return false;
//
//       }
//     });
//
//   } on SocketException catch (_) {
//     print("Perform your token refresh here in onSocket Exception");
//     return false;
//   }
// }
}
