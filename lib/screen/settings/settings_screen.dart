import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

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
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'email@mail.com',
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
              _listTileFaIcon(
                FontAwesomeIcons.user,
                Colors.blue,
                'Profile',
                () {
                  inject<Navigate>().navigateTo(ScreenConst.profile);
                },
              ),
              store
                  ? _listTileFaIcon(
                      FontAwesomeIcons.store,
                      Colors.brown,
                      'My Store',
                      () {
                        inject<Navigate>().navigateTo(ScreenConst.myStore);
                      },
                    )
                  : Container(),
              const Divider(
                height: 10,
                thickness: 10,
              ),
              _listTileIcon(
                Icons.help_outline,
                Colors.greenAccent,
                'Help',
                () {
                  //TODO: HELP PAGE
                },
              ),
              _listTileIcon(
                Icons.info_outlined,
                Colors.orange,
                'About App',
                () {
                  inject<Navigate>().navigateTo(ScreenConst.about);
                },
              ),
              _listTileFaIcon(
                FontAwesomeIcons.signOutAlt,
                Colors.black54,
                'Log Out',
                () => _showDialog(context),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Log Out',
          style: titleText16,
        ),
        content: const Text(
          'Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              inject<Navigate>().pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              //TODO: TANDA KALAU UDAH KE LOGOUT
              AuthenticationService.signOut();
              context.read<PreferencesProvider>().removeUser();
              inject<Navigate>()
                  .navigateToRemoveUntil(ScreenConst.login, ScreenConst.login);
            },
            child: const Text('Log Out'),
          ),
        ],
      );
    },
  );
}

ListTile _listTileIcon(
    IconData icon, Color color, String title, void Function() ontap) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
      size: 28,
    ),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: ontap,
  );
}

ListTile _listTileFaIcon(
    IconData icon, Color color, String title, void Function() ontap) {
  return ListTile(
    leading: FaIcon(
      icon,
      color: color,
    ),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: ontap,
  );
}
