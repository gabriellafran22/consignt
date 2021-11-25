import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CourierDropdownAirwaybill extends StatelessWidget {
  ShippingProvider provider;

  CourierDropdownAirwaybill({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      showClearButton: true,
      validator: (value) => dropdownValidation(value),
      items: const [
        {"code": "anteraja", "name": "AnterAja"},
        {"code": "jne", "name": "JNE"},
        {"code": "jnt", "name": "JNT"},
        {"code": "pos", "name": "POS Indonesia"},
        {"code": "sicepat", "name": "SiCepat"},
        {"code": "tiki", "name": "TIKI"},
        {"code": "wahana", "name": "WAHANA"},
      ],
      hint: "Courier",
      onChanged: (value) {
        if (value != null) {
          provider.courierAirwaybill = value["code"];
        } else {
          provider.courierAirwaybill = "";
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
    );
  }
}
