import 'package:flutter/material.dart';
import 'package:flutter_resto_app/data/api/api_service.dart';
import 'package:flutter_resto_app/data/model/detail_restaurant.dart';
import 'package:flutter_resto_app/provider/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({required this.apiService, required this.id}) {
    _getDetailRestaurant(id);
  }

  late DetailRestaurant _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurant get detailRestaurant => _detailRestaurant;

  ResultState get state => _state;

  String get message => _message;

  Future<dynamic> _getDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();

      final detailRestaurant = await apiService.getDetailRestaurant(id);

      if (detailRestaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();

        _message = 'No data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();

        _detailRestaurant = detailRestaurant;
      }
    } on Exception catch (e) {
      _state = ResultState.Error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
