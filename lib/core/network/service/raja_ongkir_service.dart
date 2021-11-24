import 'package:consignt/core/network/response/all_city_response.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/cost_response.dart';
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

  Future<CityResponse> getCity(String provinceId) async {
    return await clientExecutor<CityResponse>(execute: () async {
      var response =
          await _client.get('/city', queryParameters: {'province': provinceId});
      return CityResponse.fromJson(
        response.data,
      );
    });
  }

  Future<AllCityResponse> getAllCity() async {
    return await clientExecutor<AllCityResponse>(execute: () async {
      var response = await _client.get('/city');
      return AllCityResponse.fromJson(
        response.data,
      );
    });
  }

  Future<CostResponse> getCost(CostQuery costQuery) async {
    return await clientExecutor<CostResponse>(execute: () async {
      var response = await _client.post(
        '/cost',
        data: costQuery.toJson(),
      );
      return CostResponse.fromJson(response.data);
    });
  }
}
