// To parse this JSON data, do
//
//     final searchRestaurant = searchRestaurantFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_resto_app/data/model/restaurant.dart';

SearchRestaurant searchRestaurantFromJson(String str) =>
    SearchRestaurant.fromJson(json.decode(str));

String searchRestaurantToJson(SearchRestaurant data) =>
    json.encode(data.toJson());

class SearchRestaurant {
  bool error;
  int founded;
  List<ListRestaurantItem> restaurants;

  SearchRestaurant({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurant.fromJson(Map<String, dynamic> json) =>
      SearchRestaurant(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<ListRestaurantItem>.from(
            json["restaurants"].map((x) => ListRestaurantItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
