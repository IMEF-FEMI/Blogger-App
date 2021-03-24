import 'package:blogger_app/core/viewmodels/blog_list_viewmodel.dart';
import 'package:blogger_app/core/viewmodels/single_blog_viewmodel.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api/api.dart';
import 'core/services/auth_service.dart';
import 'core/services/blog_list_service.dart';
import 'core/services/sharedpreferences/shared_prefs.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => SharedPrefs());
  locator.registerLazySingleton(
    () => AuthService(
      api: locator(),
      sharedPrefs: locator(),
    ),
  );
  locator.registerFactory(
    () => BlogListService(
      api: locator(),
      sharedPrefs: locator(),
    ),
  );
  locator.registerFactory(
    () => BlogListViewModel(
      blogListService: locator(),
    ),
  );
  locator.registerFactory(
    () => SingleBlogViewModel(
      blogListService: locator(),
    ),
  );
}
