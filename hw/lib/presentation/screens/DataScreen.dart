import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../DataViewModel.dart';


class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DataViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Single Post')),
      body: FutureBuilder(
        future: viewModel.fetchData(),
        builder: (context, snapshot) {
          return Consumer<DataViewModel>(
            builder: (context, model, child) {
              if (model.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (model.error != null) {
                return Center(child: Text('Error: ${model.error}'));
              }
              if (model.data == null) {
                return const Center(child: Text('No data available'));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.data!['title']?.toString() ?? 'No title',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.data!['body']?.toString() ?? 'No body',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}