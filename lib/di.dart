import 'package:get_it/get_it.dart';

import 'common/navigate.dart';

GetIt inject = GetIt.instance;

Future setupDependencyInjection() async {
  inject.registerLazySingleton(() => Navigate());
}
