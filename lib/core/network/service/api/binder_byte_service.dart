import 'package:consignt/core/network/response/airwaybill_response.dart';
import 'package:dio/dio.dart';

class BinderByteService {
  final client = Dio();

  Future<AirwayBillResponse> getAirwayBill(String courier, String awb) async {
    var response = await client
        .get('https://api.binderbyte.com/v1/track', queryParameters: {
      'api_key':
          '47d64488656c3a506bc4cd4500141c2365521d25381b34bc7ba55e42469a792a',
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
