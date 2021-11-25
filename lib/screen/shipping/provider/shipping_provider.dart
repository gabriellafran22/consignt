import 'package:consignt/common/async.dart';
import 'package:consignt/core/custom_change_notifier.dart';
import 'package:consignt/core/model/city.dart';
import 'package:consignt/core/network/response/city_response.dart';
import 'package:consignt/core/network/response/cost_response.dart';
import 'package:consignt/core/network/service/api/raja_ongkir_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../di.dart';

class ShippingProvider extends CustomChangeNotifier {
  TextEditingController weightController = TextEditingController();
  String typeFrom = 'TYPE_FROM';
  String typeTo = 'TYPE_TO';

  ShippingProvider() {
    getAllCity();
  }

  final _rajaOngkirService = inject.get<RajaOngkirService>();

  Async<List<City>> city = uninitialized<List<City>>();
  Async<Result> result = uninitialized<Result>();

  var cityIdFrom = 0;
  var cityIdTo = 0;
  var checkPrice = false;
  String courier = '';

  Future getAllCity() async {
    customApi(
      service: _rajaOngkirService.getCity(),
      object: city,
      execute: (CityResponse response) {
        city.success(
          response.rajaongkir?.results ?? [],
        );
      },
    );
  }

  void setCityFrom(City? city) {
    if (city == null) {
      cityIdFrom = 0;
    } else {
      cityIdFrom = int.parse(city.cityId as String);
    }
    notifyListeners();
  }

  void setCityTo(City? city) {
    if (city == null) {
      cityIdTo = 0;
    } else {
      cityIdTo = int.parse(city.cityId as String);
    }

    notifyListeners();
  }

  Future getCost() async {
    CostQuery costQuery = CostQuery(
      origin: cityIdFrom.toString(),
      destination: cityIdTo.toString(),
      weight: int.parse(weightController.text),
      courier: courier,
    );

    customApi(
      service: _rajaOngkirService.getCost(costQuery),
      object: result,
      execute: (CostResponse response) {
        result.success(
          response.rajaongkir?.results?[0] ?? Result(),
        );
      },
    );
  }
}
