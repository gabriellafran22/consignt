import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../di.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool store = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.blueGrey,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/consignt_logo.jpg'),
                          radius: 40,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Name',
                                style: titleTextWhite,
                              ),
                              Text(
                                'email',
                                style: titleTextWhite,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: ListTile.divideTiles(
            color: Colors.blueGrey,
            context: context,
            tiles: [
              _listTileFaIcon(FontAwesomeIcons.user, 'Profile', () {
                inject<Navigate>().navigateTo(ScreenConst.profile);
              }),
              store
                  ? _listTileFaIcon(FontAwesomeIcons.store, 'My Store', () {
                      //TODO: MY STORE PAGE
                    })
                  : Container(),
              const Divider(
                height: 10,
                thickness: 10,
              ),
              _listTileIcon(Icons.help_outline, 'Help', () {
                //TODO: HELP PAGE
              }),
              _listTileIcon(Icons.info_outlined, 'About App', () {
                inject<Navigate>().navigateTo(ScreenConst.about);
              }),
              _listTileFaIcon(FontAwesomeIcons.signOutAlt, 'Log Out', () {
                //TODO: LOG OUT ACCOUNT
              }),
            ],
          ).toList(),
        ),
      ),
    );
  }
}

ListTile _listTileIcon(IconData icon, String title, void Function() ontap) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: ontap,
  );
}

ListTile _listTileFaIcon(IconData icon, String title, void Function() ontap) {
  return ListTile(
    leading: FaIcon(icon),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: ontap,
  );
}
