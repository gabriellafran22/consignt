import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/widget/airwaybill_result.dart';
import 'package:consignt/screen/shipping/widget/courier_dropdown_airwaybill.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';

class AirwayBillScreen extends StatelessWidget {
  ShippingProvider provider;

  AirwayBillScreen({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: provider.formKeyAirwayBill,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Courier',
                style: titleText16,
              ),
              const SizedBox(
                height: 10,
              ),
              CourierDropdownAirwaybill(
                provider: provider,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'AirwayBill',
                style: titleText16,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: provider.airwayBillController,
                validator: (value) => isEmptyFieldValidation(value),
                decoration: const InputDecoration(
                  labelText: 'AirwayBill',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Track Package',
                    style: titleTextWhite,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (provider.checkAirwayBillForm()) {
                      //TODO: ACCESS KE API
                      provider.checkAirwayBill = true;
                      print(provider.checkAirwayBill );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              provider.checkAirwayBill
                  ? AirwayBillResult()
                  // ? provider.result.isLoading
                  //     ? loadingIndicator()
                  //     : AirwayBillResult()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
