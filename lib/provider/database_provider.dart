import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/local/db/database_helper.dart';
import 'package:flutter_resto_app/data/model/restaurant.dart';
import 'package:flutter_resto_app/provider/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavoriteResto();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<ListRestaurantItem> _listFavoriteResto = [];
  List<ListRestaurantItem> get listRestaurant => _listFavoriteResto;

  void _getFavoriteResto() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      _listFavoriteResto = await databaseHelper.getFavoriteResto();

      if (_listFavoriteResto.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error : $e';
      notifyListeners();
    } finally {
      notifyListeners();
    }
  }

  Future<bool> getFavoriteRestoById(String id) async {
    final favoriteResto = await databaseHelper.getFavoriteRestoById(id);
    return favoriteResto?.isNotEmpty ?? false;
  }

  void insertFavoriteResto(ListRestaurantItem restaurant) async {
    try {
      await databaseHelper.insertFavoriteResto(restaurant);
      _getFavoriteResto();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error : $e';

      notifyListeners();
    }
  }

  void removeFavoriteResto(String id) async {
    try {
      await databaseHelper.removeFavoriteResto(id);
      _getFavoriteResto();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error : $e';
      notifyListeners();
    }
  }
}
