import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_resto_app/data/remote/api_service.dart';
import 'package:flutter_resto_app/provider/restaurant_provider.dart';
import 'package:flutter_resto_app/provider/result_state.dart';
import 'package:flutter_resto_app/utilities/style.dart';
import 'package:flutter_resto_app/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearch(context),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: _buildList()),
            ),
          ],
        ),
      ),
    );
    // return ChangeNotifierProvider(
    //   create: (context) {
    //     return RestaurantProvider(apiService: ApiService());
    //   },
    //   child: Scaffold(
    //     body: SafeArea(
    //       child: Column(
    //         children: [
    //           _buildSearch(context),
    //           Expanded(
    //             child: Padding(
    //                 padding: const EdgeInsets.only(
    //                   top: 16,
    //                   left: 16,
    //                   right: 16,
    //                 ),
    //                 child: _buildList()),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildList() {
    Consumer<RestaurantProvider> fetchListRestaurant() {
      return Consumer<RestaurantProvider>(
        builder: (context, state, child) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            final data = state.restaurantResult.restaurants;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final restaurant = data[index];
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

    Consumer<RestaurantProvider> fetchSearchRestaurant() {
      return Consumer<RestaurantProvider>(
        builder: (context, state, child) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultState.HasData) {
            final data = state.searchResult.restaurants;

            return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final restaurant = data[index];
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

    return _searchController.text.isNotEmpty
        ? fetchSearchRestaurant()
        : fetchListRestaurant();
  }

  Widget _buildSearch(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, child) => Container(
        margin: const EdgeInsets.all(16),
        child: TextFormField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchController.text = value;

              if (_searchController.text.isNotEmpty) {
                state.fetchSearchRestaurant(value);
              } else {
                state.fetchListRestaurant();
              }
            });
          },
          decoration: InputDecoration(
            fillColor: lightGrey,
            filled: true,
            contentPadding: const EdgeInsets.all(20),
            hintText: 'Search Restaurant',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: darkGrey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkGrey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: darkGrey, width: 2), // Example for focus color
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
