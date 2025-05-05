import '../ApiService.dart';

class PaginatedDataRepository {
  final ApiService _apiService;

  PaginatedDataRepository(this._apiService);

  Future<List<dynamic>> fetchPosts(int page) async {
    return await _apiService.fetchPosts(page);
  }
}