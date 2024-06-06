import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/local/db/database_helper.dart';
import 'package:flutter_resto_app/data/local/preferences/preference_helper.dart';
import 'package:flutter_resto_app/data/remote/api_service.dart';
import 'package:flutter_resto_app/pages/dashboard_page.dart';
import 'package:flutter_resto_app/pages/restaurant_detail_page.dart';
import 'package:flutter_resto_app/pages/search_page.dart';
import 'package:flutter_resto_app/provider/database_provider.dart';
import 'package:flutter_resto_app/provider/detail_restaurant_provider.dart';
import 'package:flutter_resto_app/provider/page_provider.dart';
import 'package:flutter_resto_app/provider/preference_provider.dart';
import 'package:flutter_resto_app/provider/restaurant_provider.dart';
import 'package:flutter_resto_app/utilities/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferenceProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      builder: (context, child) => MaterialApp(
        title: "Restoku App",
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.black,
                secondary: primaryColor,
              ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: poppinsTextTheme,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.black,
            surfaceTintColor: Colors.black,
          ),
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
          '/': (context) => const DashboardPage(),
          '/restaurant': (context) {
            final id = ModalRoute.of(context)?.settings.arguments as String;
            return ChangeNotifierProvider(
              create: (context) =>
                  DetailRestaurantProvider(apiService: ApiService(), id: id),
              child: const RestaurantDetailPage(),
            );
          },
          '/search': (context) => const SearchPage(),
        },
      ),
    );
  }
}
