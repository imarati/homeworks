import '../data/repositories/DataRepository.dart';

class FetchDataUseCase {
  final DataRepository _repository;

  FetchDataUseCase(this._repository);

  Future<Map<String, dynamic>> execute(int postId) async {
    try {
      final data = await _repository.fetchPost(postId);
      return data is Map<String, dynamic> ? data : {};
    } catch (e) {
      throw Exception('Failed to fetch post $postId: $e');
    }
  }
}