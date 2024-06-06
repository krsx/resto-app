import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_resto_app/data/model/detail_restaurant.dart';
import 'package:flutter_resto_app/data/model/restaurant.dart';
import 'package:flutter_resto_app/provider/database_provider.dart';
import 'package:flutter_resto_app/provider/detail_restaurant_provider.dart';
import 'package:flutter_resto_app/provider/result_state.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      floatingActionButton: Consumer<DetailRestaurantProvider>(
        builder: (context, state, child) {
          if (state.state == ResultState.HasData) {
            return handleFavoriteButton(state.detailRestaurant.restaurant);
          } else {
            return const SizedBox();
          }
        },
      ),
      body: SafeArea(
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, child) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              final restaurant = state.detailRestaurant.restaurant;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildHeadline(restaurant, context),
                    const SizedBox(
                      height: 48,
                    ),
                    _buildDescription(restaurant, context),
                  ],
                ),
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
        ),
      ),
    );
  }

  Widget handleFavoriteButton(DetaiLRestaurantItem restaurant) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: provider.getFavoriteRestoById(restaurant.id),
          builder: (context, snapshot) {
            final isFavorite = snapshot.data ?? false;
            return SizedBox(
              width: 64,
              height: 64,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000),
                ),
                backgroundColor: Colors.black,
                onPressed: () {
                  if (isFavorite) {
                    provider.removeFavoriteResto(restaurant.id);
                  } else {
                    provider.insertFavoriteResto(
                      ListRestaurantItem.fromJson(
                        restaurant.toJson(),
                      ),
                    );
                  }
                },
                child: Icon(
                  size: 28,
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Row _buildHeadline(DetaiLRestaurantItem restaurant, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontSize: 28),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              size: 24,
              color: Colors.yellow,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              restaurant.rating.toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }

  _buildDescription(DetaiLRestaurantItem restaurant, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          textAlign: TextAlign.justify,
          maxLines: 6,
          restaurant.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}
