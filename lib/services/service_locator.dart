import 'package:bloomdeliveyapp/business_logic/view_models/login/login_screen_viewmodel.dart';
import 'package:bloomdeliveyapp/services/login/login_service_strapi.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator
      .registerLazySingleton<LoginServiceStrapi>(() => LoginServiceStrapi());
  serviceLocator
      .registerLazySingleton<LocalStorageService>(() => LocalStorageService());

  serviceLocator
      .registerFactory<LoginScreenViewModel>(() => LoginScreenViewModel());
}
