import 'package:flutter/material.dart';
import '../../domain/FetchDataUseCase.dart';

class DataViewModel extends ChangeNotifier {
  final FetchDataUseCase _fetchDataUseCase;
  Map<String, dynamic>? _data;
  bool _isLoading = false;
  String? _error;

  DataViewModel(this._fetchDataUseCase);

  Map<String, dynamic>? get data => _data;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _data = await _fetchDataUseCase.execute(1); // Фиксированный ID = 1
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}