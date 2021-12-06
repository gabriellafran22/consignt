import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';

import '../../../../../di.dart';

void provinceDialog(BuildContext context, ProfileProvider provider) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Province'),
        content: SizedBox(
          height: 300,
          width: 200,
          child: provider.province.data == null
              ? const Center(
                  child: Text(
                      'Province data is still loading, please close and open it again'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.province.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var province = provider.province.data![index];
                    String provinceName = province.province ?? '';
                    return ListTile(
                      title: Text(provinceName),
                      onTap: () {
                        showSnackBar(
                          context,
                          'Province changed to: $provinceName',
                        );
                        provider.setProvince(province);
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
