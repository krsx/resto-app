import 'package:flutter/material.dart';
import 'package:flutter_resto_app/pages/favorite_page.dart';
import 'package:flutter_resto_app/pages/home_page.dart';
import 'package:flutter_resto_app/pages/settings_page.dart';
import 'package:flutter_resto_app/provider/page_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer<PageProvider>(
        builder: (context, state, child) {
          switch (state.selectedIndex) {
            case 0:
              return HomePage();
            case 1:
              return FavoritePage();
            case 2:
              return SettingsPage();
            default:
              return HomePage();
          }
        },
      )),
      bottomNavigationBar: Consumer<PageProvider>(
        builder: (context, state, child) => BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: state.selectedIndex,
          onTap: (index) => state.setIndex(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
