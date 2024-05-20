import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/api/api_service.dart';
import 'package:flutter_resto_app/data/model/list_restaurant.dart';
import 'package:flutter_resto_app/data/model/search_restaurant.dart';
import 'package:flutter_resto_app/provider/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _getList();
  }

  late ListRestaurant _listRestaurant;
  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';

  ListRestaurant get restaurantResult => _listRestaurant;

  SearchRestaurant get searchResult => _searchRestaurant;

  ResultState get state => _state;

  String get message => _message;

  void _getList({String? query}) {
    Future<dynamic> list;

    if (query == null) {
      list = _getListRestaurant();
    } else {
      list = _searchListRestaurant(query);
    }

    if (_state == ResultState.HasData) {
      list.then(
        (value) {
          if (query == null) {
            _listRestaurant = value;
          } else {
            _searchRestaurant = value;
          }
        },
      );
    }
  }

  void fetchListRestaurant() {
    _getList();
  }

  void fetchSearchRestaurant(String query) {
    _getList(query: query);
  }

  Future<dynamic> _searchListRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final searchRestaurant = await apiService.searchRestaurant(query);

      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();

        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();

        return _searchRestaurant = searchRestaurant;
      }
    } on Exception catch (e) {
      _state = ResultState.Error;
      notifyListeners();

      return _message = 'Error: $e';
    }
  }

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
    } on Exception catch (e) {
      _state = ResultState.Error;
      notifyListeners();

      return _message = 'Error: $e';
    }
  }
}
