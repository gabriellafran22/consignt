import 'package:consignt/common/styles.dart';
import 'package:consignt/core/network/response/cost_response.dart';
import 'package:flutter/material.dart';

class ShippingPriceCard extends StatelessWidget {
  const ShippingPriceCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Result? result;

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
                result?.name ?? '',
                style: titleText(20),
              ),
              const SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                itemCount: result?.costs?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var resultCost = result?.costs?[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(resultCost?.service ?? 'Service'),
                            Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                    resultCost?.description ?? 'Description'),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Rp. ${resultCost?.cost?[0].value}'),
                            Container(
                                margin: const EdgeInsets.only(top: 5),
                                child:
                                    Text('${resultCost?.cost?[0].etd} days'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
