import 'package:consignt/core/network/response/airwaybill_response.dart';
import 'package:dio/dio.dart';

class BinderByteService {
  final client = Dio();

  Future<AirwayBillResponse> getAirwayBill(String courier, String awb) async {
    var response = await client
        .get('https://api.binderbyte.com/v1/track', queryParameters: {
      'api_key':
          '65118d45e8714205cdb35ecd207e76edbc16d5c0008f3cbd710d5e9b889e61b7',
      'courier': courier,
      'awb': awb
    });

    if (response.statusCode == 200) {
      return AirwayBillResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load airwayBill');
    }
  }
}
