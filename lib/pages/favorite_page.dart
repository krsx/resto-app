import 'package:flutter/material.dart';
import 'package:flutter_resto_app/provider/database_provider.dart';
import 'package:flutter_resto_app/provider/result_state.dart';
import 'package:flutter_resto_app/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      surfaceTintColor: Colors.white,
      elevation: 0,
      backgroundColor: Colors.white,
      expandedHeight: 125,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
        ),
        titlePadding: const EdgeInsets.only(
          left: 16,
          bottom: 16,
        ),
        title: Text(
          'Favorite Resto',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildAppBar(context),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Consumer<DatabaseProvider>(
              builder: (context, provider, child) {
                if (provider.state == ResultState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.state == ResultState.HasData) {
                  return ListView.builder(
                    itemCount: provider.listRestaurant.length,
                    itemBuilder: (context, index) {
                      final favorite = provider.listRestaurant[index];
                      return RestaurantCard(restaurant: favorite);
                    },
                  );
                } else if (provider.state == ResultState.NoData) {
                  return const Center(
                    child: Text('No Data'),
                  );
                } else if (provider.state == ResultState.Error) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: Text('Data Loaded'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
