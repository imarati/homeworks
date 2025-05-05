import '../ApiService.dart';

class DataRepository {
  final ApiService _apiService;

  DataRepository(this._apiService);

  Future<Map<String, dynamic>> fetchPost(int id) async {
    return await _apiService.fetchPost(id);
  }
}