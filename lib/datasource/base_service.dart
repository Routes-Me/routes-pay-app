import 'package:routes_pay/ui/model/data_model.dart';

abstract class BaseService {
  final String baseUrl = "https://stage.api.routesme.com/api/v1.0/";

  Future<dynamic> getResponse(SignInModel signInModel,String url);

  Future<dynamic> postResponse(String url);
}