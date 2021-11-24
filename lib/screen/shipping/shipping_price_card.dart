import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';

class ShowShippingPrice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'JNE',
                style: titleText20,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Regular'),
                    trailing: Text('Rp. Harga'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
