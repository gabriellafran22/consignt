import 'package:consignt/di.dart';
import 'package:consignt/preferences/preferences_helper.dart';
import 'package:consignt/preferences/preferences_provider.dart';
import 'package:consignt/screen/init/provider/init_provider.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_helper.dart';
import 'package:consignt/screen/search/search/search_history_database/search_history_database_provider.dart';
import 'package:consignt/screen/search/search_result/provider/search_result_provider.dart';
import 'package:consignt/screen/shipping/provider/shipping_provider.dart';
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
        ChangeNotifierProvider(
          create: (_) => SearchHistoryDatabaseProvider(
            searchHistoryDatabaseHelper: SearchHistoryDatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => InitProvider()),
        ChangeNotifierProvider(create: (_) => SearchResultProvider()),
        ChangeNotifierProvider(create: (_) => ShippingProvider()),
      ],
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
    );
  }
}
