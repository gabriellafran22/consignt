import 'package:consignt/screen/favorite/favorite_screen.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/init/provider/init_provider.dart';
import 'package:consignt/screen/settings/settings_screen.dart';
import 'package:consignt/screen/shipping/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final List<Widget> _listWidget = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ShippingScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<InitProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: _listWidget[provider.bottomNavIndex],
          bottomNavigationBar: BottomNavigationBar(
            elevation: 30,
            type: BottomNavigationBarType.fixed,
            currentIndex: provider.bottomNavIndex,
            items: [
              BottomNavigationBarItem(
                icon: provider.bottomNavIndex == 0
                    ? const Icon(
                        Icons.home,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.home_outlined,
                        color: Colors.black54,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: provider.bottomNavIndex == 1
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.black54,
                      ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: provider.bottomNavIndex == 2
                    ? const FaIcon(
                        FontAwesomeIcons.shippingFast,
                        color: Colors.purple,
                      )
                    : const FaIcon(
                        FontAwesomeIcons.truck,
                        color: Colors.black54,
                      ),
                label: 'Shipping',
              ),
              BottomNavigationBarItem(
                icon: provider.bottomNavIndex == 3
                    ? const Icon(
                        Icons.settings,
                        color: Colors.deepOrange,
                      )
                    : const Icon(
                        Icons.settings_outlined,
                        color: Colors.black54,
                      ),
                label: 'Settings',
              ),
            ],
            onTap: (int index) {
              provider.setNavIndex(index);
            },
          ),
        );
      },
    );
  }
}
