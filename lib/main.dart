import 'package:consignt/di.dart';
import 'package:consignt/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/navigate.dart';
import 'core/routes.dart';

Future<void> main() async {
  await setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
