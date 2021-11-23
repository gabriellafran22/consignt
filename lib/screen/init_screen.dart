import 'package:consignt/screen/favorite/favorite_screen.dart';
import 'package:consignt/screen/home/home_screen.dart';
import 'package:consignt/screen/settings/settings_screen.dart';
import 'package:consignt/screen/shipping/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ShippingScreen(),
    const SettingsScreen(),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 30,
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavIndex,
        items: [
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 0
                ? const Icon(Icons.home)
                : const Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 1
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 2
                ? const FaIcon(FontAwesomeIcons.shippingFast)
                : const FaIcon(FontAwesomeIcons.truck),
            label: 'Shipping',
          ),
          BottomNavigationBarItem(
            icon: _bottomNavIndex == 3
                ? const Icon(Icons.settings)
                : const Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
