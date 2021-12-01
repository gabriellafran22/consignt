import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/core/model/user.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/settings/widget_dialog/logout_dialog.dart';
import 'package:consignt/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../di.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel dataUser = UserModel();
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
                  child: FutureBuilder(
                    future: context.read<PreferencesProvider>().getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        UserModel user = snapshot.data as UserModel;
                        dataUser = user;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          color: Colors.blueGrey,
                          child: Row(
                            children: [
                              user.profilePicture == ''
                                  ? Container(
                                      width: 80,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${user.name?.substring(0, 1)}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        user.profilePicture ?? '',
                                      ),
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
                                      user.name ?? 'Your Name',
                                      style: titleTextWhite,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      user.email ?? 'Your Email',
                                      style: titleTextWhite,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return loadingIndicator();
                      }
                    },
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
              dataUser.isSeller ?? false
                  ? _listTileFaIcon(
                      FontAwesomeIcons.store,
                      Colors.brown,
                      'My Store',
                      () {
                        inject<Navigate>().navigateTo(ScreenConst.myStore);
                      },
                    )
                  : _listTileFaIcon(
                      FontAwesomeIcons.store,
                      Colors.brown,
                      'Create Store',
                      () {
                        inject<Navigate>().navigateTo(ScreenConst.createStore);
                      },
                    ),
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
                () => showLogoutDialog(context),
              ),
            ],
          ).toList(),
        ),
      ),
    );
  }
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
