import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../PaginationDataViewModel.dart';

class PaginatedDataScreen extends StatefulWidget {
  const PaginatedDataScreen({super.key});

  @override
  State<PaginatedDataScreen> createState() => _PaginatedDataScreenState();
}

class _PaginatedDataScreenState extends State<PaginatedDataScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Загружаем первую страницу при инициализации
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaginationDataViewModel>().loadPage(1);
    });

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<PaginationDataViewModel>().nextPage();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paginated Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<PaginationDataViewModel>().refreshData(),
          ),
        ],
      ),
      body: Consumer<PaginationDataViewModel>(
        builder: (context, model, child) {
          if (model.items.isEmpty && model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _buildPaginationControls(model),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => model.refreshData(),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: model.items.length + (model.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= model.items.length) {
                        return const Center(child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ));
                      }

                      final item = model.items[index];
                      return ListTile(
                        title: Text(item['title']?.toString() ?? 'No title'),
                        subtitle: Text(item['body']?.toString() ?? 'No body'),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPaginationControls(PaginationDataViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: model.currentPage > 1
                ? () => model.prevPage()
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Page ${model.currentPage}${model.totalPages != null ? '/${model.totalPages}' : ''}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: model.hasMore
                ? () => model.nextPage()
                : null,
          ),
        ],
      ),
    );
  }
}