import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchPost(int id) async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts/$id');
    return response.data;
  }

  Future<List<dynamic>> fetchPosts(int page) async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      queryParameters: {'_page': page, '_limit': 10},
    );

    // Если API возвращает общее количество элементов в заголовках
    // final totalCount = int.tryParse(response.headers.value('x-total-count') ?? '0') ?? 0;
    // final totalPages = (totalCount / 10).ceil();
    // Можно передать эту информацию в репозиторий

    return response.data;
  }
}