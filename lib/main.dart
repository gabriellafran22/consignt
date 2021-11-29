import 'package:consignt/core/network/service/firebase/authentication_service.dart';
import 'package:consignt/di.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigate.dart';
import 'core/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: StreamProvider.value(
        initialData: null,
        value: AuthenticationService.userStream,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Consignt',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme: GoogleFonts.ubuntuTextTheme(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: routes,
          navigatorKey: inject<Navigate>().navigatorKey,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
