import 'package:get_it/get_it.dart';
import '../business_logic/view_models/task_view_model.dart';
import '../business_logic/view_models/home_view_model.dart';
import '../business_logic/view_models/login_view_model.dart';
import '../business_logic/view_models/register_view_model.dart';

GetIt dependencyAssembler = GetIt.instance;

Future<void> setupDependencyAssemblerEducation() async {
  //Services
  dependencyAssembler.registerFactory<LoginViewModel>(() => LoginViewModel());
  dependencyAssembler
      .registerFactory<RegisterViewModel>(() => RegisterViewModel());

  dependencyAssembler.registerLazySingleton(() => HomeViewModel());
  dependencyAssembler.registerLazySingleton(() => TaskViewModel());
}
