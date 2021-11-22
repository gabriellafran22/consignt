import 'package:consignt/common/colors.dart';
import 'package:consignt/common/styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  static const routeName = '/home_buyer_page';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search a product',
                  border: InputBorder.none,
              ),
              onTap: () {
                //TODO: PINDAH KE SEARCH PAGE
              },
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/consignt_logo.jpg'),
                    radius: 40,
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: Text('User profile name (if set), else => email', style: titleText,),
                  ),
                  //TODO: KALAU NAMANYA KEPANJANGAN, HARUSNYA DRAWER HEADER BISA AUTO BESARIN UKURANNYA
                ],
              )
              //TODO: profile picture & nama orang yg login
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                //TODO: GO TO BUYER PROFILE PAGE
              },
            ),
            ListTile(
              leading: Icon(Icons.switch_account_rounded),
              title: const Text('Switch to seller account'),
              onTap: () {
                //TODO: GO TO SELLER HOME PAGE
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                //TODO: GO TO BUYER HELP PAGE
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                //TODO: GO TO BUYER ABOUT PAGE
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                //TODO: GO TO BUYER LOGIN PAGE & KASIH PENANDA KALAU UDAH GA LOG IN
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          //TODO: CONTENT LIST TILE / GRID OF PRODUCTS
        ),
      )
    );
  }

}