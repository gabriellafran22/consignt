import 'package:consignt/common/styles.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
import 'package:consignt/screen/shipping/screen/airwaybill_screen.dart';
import 'package:consignt/screen/shipping/screen/shipping_cost_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Information',
          style: titleTextWhite,
        ),
        bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                child: Text(
                  'Shipping Cost',
                  style: titleTextWhite,
                ),
              ),
              Tab(
                child: Text(
                  'AirwayBill',
                  style: titleTextWhite,
                ),
              ),
            ]),
      ),
      body: ChangeNotifierProvider<ShippingProvider>(
        create: (_) => ShippingProvider(),
        child: Consumer<ShippingProvider>(
          builder: (context, provider, _) {
            return TabBarView(controller: tabController, children: [
              ShippingCostScreen(provider: provider),
              AirwayBillScreen(provider: provider),
            ]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
}
