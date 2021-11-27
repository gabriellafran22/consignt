import 'package:consignt/common/validation.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CourierDropdownCost extends StatelessWidget {
  final ShippingProvider provider;

  const CourierDropdownCost({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Map<String, dynamic>>(
      showClearButton: true,
      validator: (value) => dropdownValidation(value),
      items: const [
        {"code": "jne", "name": "JNE"},
        {"code": "pos", "name": "POS Indonesia"},
        {"code": "tiki", "name": "TIKI"},
      ],
      hint: "Courier",
      maxHeight: 180,
      onChanged: (value) {
        if (value != null) {
          provider.courierCost = value["code"];
        } else {
          provider.courierCost = "";
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
