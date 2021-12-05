import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/widget/airwaybill_result_card.dart';
import 'package:consignt/screen/shipping/widget/courier_dropdown_airwaybill.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';

class AirwayBillScreen extends StatelessWidget {
  final ShippingProvider provider;

  const AirwayBillScreen({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: provider.formKeyAirwayBill,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Courier',
                style: titleText(16),
              ),
              const SizedBox(
                height: 10,
              ),
              CourierDropdownAirwayBill(
                provider: provider,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'AirwayBill',
                style: titleText(16),
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
                  style: fullyRoundedButton(),
                  onPressed: () {
                    if (provider.checkAirwayBillForm()) {
                      provider.getAirwayBill();
                      provider.checkAirwayBill = true;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _airwayBillHandler(provider),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _airwayBillHandler(ShippingProvider provider) {
  if (provider.checkAirwayBill == true) {
    if (provider.state == ResultState.loading) {
      return loadingIndicator();
    } else if (provider.state == ResultState.hasData) {
      return AirwayBillResultCard(
        airwayBillData: provider.airwayBillData,
      );
    } else if (provider.state == ResultState.noData) {
      return Center(
        child: Text(
          'Invalid tracking number, \nplease check your airwayBill number again',
          style: titleText(16),
          textAlign: TextAlign.center,
        ),
      );
    } else if (provider.state == ResultState.error) {
      return Center(
        child: Text(
          'Invalid tracking number, \nplease check your airwayBill number again',
          style: titleText(16),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return Container();
    }
  } else {
    return Container();
  }
}
