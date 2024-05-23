import 'package:flutter/material.dart';
import 'package:flutter_resto_app/provider/restaurant_provider.dart';
import 'package:flutter_resto_app/provider/result_state.dart';
import 'package:flutter_resto_app/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.restaurantResult.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.restaurantResult.restaurants[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(
            child: Text('Data Loaded'),
          );
        }
      },
    );
  }

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
          'Restoku App',
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(color: Colors.black),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          icon: const Icon(
            Icons.search,
            size: 28,
            color: Colors.black,
          ),
        ),
      ],
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
              top: 20,
            ),
            child: _buildList(),
          ),
        ),
      ),
    );
  }
}
