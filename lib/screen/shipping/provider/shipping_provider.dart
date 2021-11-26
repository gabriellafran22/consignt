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
  TextEditingController airwayBillController = TextEditingController();
  final GlobalKey<FormState> formKeyShippingCost = GlobalKey();
  final GlobalKey<FormState> formKeyAirwayBill = GlobalKey();
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
  var checkAirwayBill = false;
  String courierCost = '';
  String courierAirwaybill = '';

  bool checkPriceForm() {
    final bool isValid = formKeyShippingCost.currentState!.validate();
    if (isValid) {
      return true;
    }
    return false;
  }

  bool checkAirwayBillForm() {
    final bool isValid = formKeyAirwayBill.currentState!.validate();
    if (isValid) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

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
      courier: courierCost,
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

  @override
  void dispose() {
    weightController.dispose();
    airwayBillController.dispose();
    super.dispose();
  }
}
