import 'package:http_interceptor/models/retry_policy.dart';

class ExpireRetryPolicy extends RetryPolicy{

  @override
  int maxRetryAttempts = 10;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {

    return super.shouldAttemptRetryOnException(reason);
  }

}