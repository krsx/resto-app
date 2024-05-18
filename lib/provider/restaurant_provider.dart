import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/api/api_service.dart';
import 'package:flutter_resto_app/data/model/list_restaurant.dart';
import 'package:flutter_resto_app/provider/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _getListRestaurant();
  }

  late ListRestaurant _listRestaurant;
  late ResultState _state;
  String _message = '';

  ListRestaurant get result => _listRestaurant;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _getListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final listRestaurant = await apiService.getListRestaurant();

      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
