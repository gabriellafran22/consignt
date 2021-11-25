import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/response/cost_response.dart';
import 'package:flutter/material.dart';

class AirwayBillResult extends StatelessWidget {
  final Result? result;

  const AirwayBillResult({Key? key, this.result}) : super(key: key);

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Airwaybill Number',
                  style: titleText20,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Package Overview',
                style: titleText16,
              ),
              const SizedBox(height: 10),
              //TODO: CEK DLU, KALO DATANYA KOSONG GAUSAH DI TAMPILIN
              _rowText('Courier', 'CourierName'),
              _rowText('Service', 'Service'),
              _rowText('Status', 'xxxxxx'),
              _rowText('Amount', 'xxxxxx'),
              _rowText('Weight', 'xxxxxx'),
              const Divider(
                thickness: 5,
                height: 30,
              ),
              Text(
                'Package Detail',
                style: titleText16,
              ),
              const SizedBox(height: 10),
              _rowText('Origin', 'xxxxxx'),
              _rowText('Destination', 'xxxxxx'),
              _rowText('Shipper', 'xxxxxx'),
              _rowText('Receiver', 'xxxxxx'),
              const Divider(
                thickness: 5,
                height: 30,
              ),
              Text(
                'Package Process',
                style: titleText16,
              ),
              const SizedBox(
                height: 8,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return _rowText('Receiver', 'xxxxxx');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _rowText(String title, String content) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleText14,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}
