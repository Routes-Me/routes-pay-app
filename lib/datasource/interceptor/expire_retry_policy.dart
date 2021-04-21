import 'package:flutter/src/widgets/framework.dart';
import 'package:http_interceptor/models/retry_policy.dart';

class ExpireRetryPolicy extends RetryPolicy {
  @override
  int maxRetryAttempts = 10;

  ExpireRetryPolicy(BuildContext context);

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return super.shouldAttemptRetryOnException(reason);
  }
}
