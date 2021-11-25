import 'package:consignt/common/styles.dart';
import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/widget/shipping_price_card.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/all_city_widget.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check Shipping Fees',
          style: titleTextWhite,
        ),
      ),
      body: ChangeNotifierProvider<ShippingProvider>(
        create: (_) => ShippingProvider(),
        child: Consumer<ShippingProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: provider.formKey,
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
                      DropdownSearch<Map<String, dynamic>>(
                        // mode: Mode.MENU,
                        showClearButton: true,
                        validator: (value) => dropdownValidation(value),
                        items: const [
                          {"code": "jne", "name": "JNE"},
                          {"code": "pos", "name": "POS Indonesia"},
                          {"code": "tiki", "name": "TIKI"},
                        ],
                        label: "Courier",
                        onChanged: (value) {
                          if (value != null) {
                            provider.courier = value["code"];
                          } else {
                            provider.courier = "";
                          }
                        },
                        itemAsString: (item) => "${item['name']}",
                        popupItemBuilder: (context, item, isSelected) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "${item['name']}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
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
          },
        ),
      ),
    );
  }
}
