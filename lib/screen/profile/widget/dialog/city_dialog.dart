import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../../../di.dart';

void cityDialog(BuildContext context, ProfileProvider provider) {
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
                            showSnackBar(
                              context,
                              'City changed to: $cityType $cityName',
                            );
                            provider.setCity(city);
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
