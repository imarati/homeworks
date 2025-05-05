import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/ApiService.dart';
import 'data/repositories/DataRepository.dart';
import 'data/repositories/PaginationDataRepository.dart';
import 'domain/FetchDataUseCase.dart';
import 'domain/FetchPaginationDataUseCase.dart';
import 'presentation/DataViewModel.dart';
import 'presentation/PaginationDataViewModel.dart';
import 'presentation/screens/DataScreen.dart';
import 'presentation/screens/PaginatedDataScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Базовые сервисы
        Provider(create: (_) => ApiService()),

        // Репозитории
        Provider<DataRepository>(
          create: (context) => DataRepository(context.read<ApiService>()),
        ),
        Provider<PaginatedDataRepository>(
          create: (context) => PaginatedDataRepository(context.read<ApiService>()),
        ),

        // Use Cases
        Provider<FetchDataUseCase>(
          create: (context) => FetchDataUseCase(context.read<DataRepository>()),
        ),
        Provider<FetchPaginationDataUseCase>(
          create: (context) => FetchPaginationDataUseCase(context.read<PaginatedDataRepository>()),
        ),

        // ViewModels
        ChangeNotifierProvider<DataViewModel>(
          create: (context) => DataViewModel(context.read<FetchDataUseCase>()),
        ),
        ChangeNotifierProvider<PaginationDataViewModel>(
          create: (context) => PaginationDataViewModel(context.read<FetchPaginationDataUseCase>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Clean Architecture'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DataScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Single Post',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaginatedDataScreen()),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Paginated Posts',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}