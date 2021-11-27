import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/widget/all_city_widget.dart';
import 'package:consignt/screen/shipping/widget/courier_dropdown_cost.dart';
import 'package:consignt/screen/shipping/widget/shipping_price_card.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';

class ShippingCostScreen extends StatelessWidget {
  final ShippingProvider provider;

  const ShippingCostScreen({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          key: provider.formKeyShippingCost,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'From (Origin City)',
                style: titleText16,
              ),
              const SizedBox(
                height: 10,
              ),
              AllCityWidget(
                provider: provider,
                dropdownSearchType: provider.typeFrom,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'To (Destination City)',
                style: titleText16,
              ),
              const SizedBox(
                height: 10,
              ),
              AllCityWidget(
                provider: provider,
                dropdownSearchType: provider.typeTo,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: provider.weightController,
                keyboardType: TextInputType.number,
                validator: (value) => isEmptyFieldValidation(value),
                decoration: const InputDecoration(
                  suffix: Text(
                    'Grams',
                  ),
                  labelText: 'Weight',
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
              Text(
                'Courier',
                style: titleText16,
              ),
              const SizedBox(
                height: 10,
              ),
              CourierDropdownCost(
                provider: provider,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    'Check Price',
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
                    if (provider.checkPriceForm()) {
                      provider.getCost();
                      provider.checkPrice = true;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              provider.checkPrice
                  ? provider.result.isLoading
                      ? loadingIndicator()
                      : ShippingPriceCard(result: provider.result.data)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
