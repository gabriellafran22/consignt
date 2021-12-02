import 'package:consignt/common/navigate.dart';
import 'package:consignt/common/snackbar.dart';
import 'package:consignt/common/styles.dart';
import 'package:consignt/constant/screen_const.dart';
import 'package:consignt/di.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/screen/profile/provider/profile_provider.dart';
import 'package:consignt/screen/profile/widget/profile_detail.dart';
import 'package:consignt/screen/profile/widget/profile_picture.dart';
import 'package:consignt/widget/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(
        preferencesHelper: PreferencesHelper(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'My Profile',
                style: titleTextWhite,
              ),
              actions: [
                provider.isDataChanged
                    ? IconButton(
                        icon: const FaIcon(FontAwesomeIcons.check),
                        onPressed: () {
                          provider.updateData();
                          showSnackBar(context, 'Data Updated');
                          inject<Navigate>().pop();
                          inject<Navigate>().navigateTo(
                            ScreenConst.init,
                            popPrevious: true,
                          );
                        },
                      )
                    : const SizedBox(),
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  if (provider.isDataChanged) {
                    backDialog(context);
                  } else {
                    inject<Navigate>().pop();
                  }
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 150,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.blueGrey,
                    child: Center(
                      child: ProfilePicture(
                        provider: provider,
                      ),
                    ),
                  ),
                  ProfileDetail(
                    provider: provider,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
