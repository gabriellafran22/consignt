import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/response/airwaybill_response.dart';
import 'package:consignt/core/network/response/cost_response.dart';
import 'package:flutter/material.dart';

class AirwayBillResultCard extends StatelessWidget {
  final Result? result;
  final Data? airwayBillData;

  const AirwayBillResultCard(
      {Key? key, this.result, required this.airwayBillData})
      : super(key: key);

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
                  airwayBillData!.summary?.awb ?? '',
                  style: titleText(20),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Package Overview',
                style: titleText(16),
              ),
              const SizedBox(height: 10),
              _rowText(
                  'Courier',
                  airwayBillData!.summary!.courier!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.courier ?? '-'),
              _rowText(
                  'Service',
                  airwayBillData!.summary!.service!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.service ?? '-'),
              _rowText(
                  'Status',
                  airwayBillData!.summary!.status!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.status ?? '-'),
              _rowText(
                  'Date',
                  airwayBillData!.summary!.date!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.date ?? '-'),
              _rowText(
                  'Amount',
                  airwayBillData!.summary!.amount!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.amount ?? '-'),
              _rowText(
                  'Weight',
                  airwayBillData!.summary!.weight!.isEmpty
                      ? '-'
                      : airwayBillData!.summary?.weight ?? '-'),
              const Divider(
                thickness: 5,
                height: 30,
              ),
              Text(
                'Package Detail',
                style: titleText(16),
              ),
              const SizedBox(height: 10),
              _rowText(
                  'Origin',
                  airwayBillData!.detail!.origin!.isEmpty
                      ? '-'
                      : airwayBillData!.detail?.origin ?? '-'),
              _rowText(
                  'Destination',
                  airwayBillData!.detail!.destination!.isEmpty
                      ? '-'
                      : airwayBillData!.detail?.destination ?? '-'),
              _rowText(
                  'Shipper',
                  airwayBillData!.detail!.shipper!.isEmpty
                      ? '-'
                      : airwayBillData!.detail?.shipper ?? '-'),
              _rowText(
                  'Receiver',
                  airwayBillData!.detail!.receiver!.isEmpty
                      ? '-'
                      : airwayBillData!.detail?.receiver ?? '-'),
              const Divider(
                thickness: 5,
                height: 30,
              ),
              Text(
                'Package Process',
                style: titleText(16),
              ),
              const SizedBox(
                height: 10,
              ),
              airwayBillData!.history![0].date!.isEmpty
                  ? Container(
                      margin: const EdgeInsets.only(top: 15, bottom: 25),
                      child: Center(
                        child: Text(
                          'History Data Not Available',
                          style: titleText(16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: airwayBillData!.history!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _rowText(
                            airwayBillData!.history![index].date.toString(),
                            airwayBillData!.history![index].desc.toString());
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
          style: titleText(14),
        ),
        const SizedBox(
          width: 20,
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
