import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/widget/shipping_price_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/all_city_widget.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  bool checkPrice = false;

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
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                    TextField(
                      controller: provider.weightController,
                      keyboardType: TextInputType.number,
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
                          //TODO: CHECK ONGKIR
                          setState(() {
                            checkPrice = true;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    checkPrice ?
                    ShowShippingPrice() :
                    Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
