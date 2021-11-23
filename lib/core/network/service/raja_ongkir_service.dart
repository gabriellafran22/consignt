import 'package:consignt/core/network/response/province_response.dart';
import 'package:dio/dio.dart';

import '../client.dart';

class RajaOngkirService {
  final Dio _client;

  RajaOngkirService(this._client);

  Future<ProvinceResponse> getProvince() async {
    return await clientExecutor<ProvinceResponse>(execute: () async {
      var response = await _client.get('/province');
      return ProvinceResponse.fromJson(
        response.data,
      );
    });
  }
}
