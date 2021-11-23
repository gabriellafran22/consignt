import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'common/navigate.dart';
import 'core/network/client.dart';
import 'core/network/service/raja_ongkir_service.dart';

GetIt inject = GetIt.instance;

Future setupDependencyInjection() async {
  inject.registerLazySingleton(() => Navigate());
  inject.registerLazySingleton<Dio>(
    () => ApiClient.instance(baseUrl: 'https://api.rajaongkir.com/starter'),
  );
  inject.registerLazySingleton<RajaOngkirService>(
      () => RajaOngkirService(inject()));
}
