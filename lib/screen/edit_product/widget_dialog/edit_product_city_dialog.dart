import 'package:consignt/common/navigate.dart';
import 'package:consignt/screen/edit_product/edit_product_provider/edit_product_provider.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';

void editProductCityDialog(BuildContext context, EditProductProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('City'),
        content: SizedBox(
          height: 300,
          width: 200,
          child: provider.provinceId == '0'
              ? const Center(
                  child: Text(
                    'Please click a province first',
                  ),
                )
              : provider.city.data == null
                  ? const Center(
                      child: Text(
                        'City data is still loading, please close and open it again',
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: provider.city.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var city = provider.city.data![index];
                        String cityType = city.type ?? '';
                        String cityName = city.cityName ?? '';
                        return ListTile(
                          title: Text('$cityType $cityName'),
                          onTap: () {
                            provider.setProductCity(city);
                            inject<Navigate>().pop();
                          },
                        );
                      },
                    ),
        ),
      );
    },
  );
}
