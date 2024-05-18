import 'package:flutter/material.dart';
import 'package:flutter_resto_app/pages/home_page.dart';
import 'package:flutter_resto_app/pages/restaurant_detail_page.dart';
import 'package:flutter_resto_app/pages/search_page.dart';
import 'package:flutter_resto_app/utilities/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Restoku App",
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              secondary: primaryColor,
            ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: poppinsTextTheme,
        appBarTheme: const AppBarTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/restaurant': (context) => const RestaurantPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
