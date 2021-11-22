import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/widgets/product_grid_card.dart';
import 'package:consignt/widgets/product_list_card.dart';
import 'package:flutter/material.dart';

import '../../di.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search a product',
                  border: InputBorder.none,
                ),
                onTap: () {
                  //TODO: PINDAH KE SEARCH PAGE
                },
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isListView) {
                      isListView = false;
                    } else {
                      isListView = true;
                    }
                  });
                },
                icon: isListView
                    ? const Icon(Icons.format_list_bulleted)
                    : const Icon(Icons.grid_view))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: Column(
                    //TODO: profile picture & nama orang yg login
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/consignt_logo.jpg'),
                        radius: 40,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Text(
                          'User Name',
                          style: titleTextWhite,
                        ),
                      ),
                    ],
                  )),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  //TODO: GO TO PROFILE PAGE
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {
                  //TODO: GO TO HELP PAGE
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  inject<Navigate>().navigateTo(ScreenConst.about);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  //TODO: KASIH PENANDA KALAU UDAH GA LOG IN
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              //TODO: CONTENT LIST TILE / GRID OF PRODUCTS
              child: isListView
                  ? Column(
                      //TODO NANTI GANTI LIST VIEW
                      children: [
                        productListCard(context),
                        productListCard(context),
                      ],
                    )
                  : Column(
                      //TODO NANTI GANTI GRID VIEW
                      children: [
                        productGridCard(),
                        productGridCard(),
                      ],
                    )),
        ));
  }
}
