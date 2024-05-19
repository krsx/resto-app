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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = state.result.restaurants[index];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildAppBar(context),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildAppBar(context),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: _buildList(),
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Restoku App',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          icon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     title: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Restoku App',
  //           style: Theme.of(context).textTheme.displayLarge,
  //         ),
  //         const SizedBox(
  //           height: 4,
  //         ),
  //         Text(
  //           'Your relible restaurant\ninformation provider',
  //           style: Theme.of(context)
  //               .textTheme
  //               .titleSmall
  //               ?.copyWith(color: Colors.grey),
  //         ),
  //       ],
  //     ),
  //     actions: [
  //       IconButton(
  //         onPressed: () {
  //           Navigator.pushNamed(context, '/search');
  //         },
  //         icon: const Icon(Icons.search),
  //       ),
  //     ],
  //   );
  // }
}
