import 'package:flutter/material.dart';
import '../../domain/FetchPaginationDataUseCase.dart';

class PaginationDataViewModel extends ChangeNotifier {
  final FetchPaginationDataUseCase _fetchPaginationDataUseCase;

  List<dynamic> _items = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;
  int? _totalPages;

  List<dynamic> get items => _items;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  int? get totalPages => _totalPages;

  PaginationDataViewModel(this._fetchPaginationDataUseCase);

  Future<void> loadPage(int page) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newItems = await _fetchPaginationDataUseCase.execute(page);
      _items = newItems;
      _currentPage = page;
      _hasMore = newItems.isNotEmpty;

      // Обновляем общее количество страниц (если API предоставляет эту информацию)
      // _totalPages = ...;
    } catch (e) {
      debugPrint('Error loading page: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> nextPage() async {
    if (_hasMore) {
      await loadPage(_currentPage + 1);
    }
  }

  Future<void> prevPage() async {
    if (_currentPage > 1) {
      await loadPage(_currentPage - 1);
    }
  }

  Future<void> refreshData() async {
    _items.clear();
    _hasMore = true;
    await loadPage(1);
  }
}