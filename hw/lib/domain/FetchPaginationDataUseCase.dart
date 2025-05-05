import '../data/repositories/PaginationDataRepository.dart';

class FetchPaginationDataUseCase {
  final PaginatedDataRepository _repository; // Изменен тип

  FetchPaginationDataUseCase(this._repository);

  Future<List<dynamic>> execute(int page) async {
    try {
      final data = await _repository.fetchPosts(page);
      return data is List ? data : [];
    } catch (e) {
      throw Exception('Failed to fetch page $page: $e');
    }
  }
}