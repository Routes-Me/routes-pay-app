import 'package:get_it/get_it.dart';
import 'package:routes_pay/ui/repository/user_repository.dart';
import 'package:routes_pay/ui/viewmodel/login_viewmodel.dart';

GetIt  locator = GetIt.asNewInstance();

void setUpLocation(){
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => UserRepository());
}
