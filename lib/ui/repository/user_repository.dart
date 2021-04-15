import 'package:routes_pay/data/pojo/user.dart';
import 'package:routes_pay/datasource/data_source.dart';
import 'package:routes_pay/ui/model/data_model.dart';
import '../../datasource/base_service.dart';

class UserRepository{

  BaseService baseService = DataSource();
  Future<User> signIn(SignInModel parameter) async {
    String url = "";
    dynamic response = await baseService.getResponse(parameter,url);
    final jsonData = response['token'];
    print('$jsonData');
    //User userItem = jsonData.map((tagJson) => User.fromJson(tagJson));
    User userItem = User(token:jsonData);
    return userItem;
  }

}