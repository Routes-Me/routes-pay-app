import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/data_source.dart';
import 'package:routes_pay/ui/model/data_model.dart';
import '../../datasource/base_service.dart';

class UserRepository{

  BaseService baseService = DataSource();
  Future<User> signIn(Map<String, String> params) async {
    String url = "authentications";
    dynamic response = await baseService.postResponse(params,url);
    final jsonData = response['token'];
    print('Response $jsonData');
    //User userItem = jsonData.map((tagJson) => User.fromJson(tagJson));
    User userItem = User(token:jsonData);
    return userItem;
  }

}