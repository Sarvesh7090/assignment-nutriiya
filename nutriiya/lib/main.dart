import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/view/features/dashboard/data/model/movie_model.dart';
import 'app/view/features/dashboard/presentation/page/dashboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional: Only if you still need SSL bypass for local testing
  HttpOverrides.global = MyHttpOverrides();

  // Hive Init
  await Hive.initFlutter();

  // Register Adapters
  Hive.registerAdapter(MovieResponseModelAdapter());
  Hive.registerAdapter(SearchAdapter());

  // Open Hive Box
  await Hive.openBox('moviebox');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Feed App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: DashboardScreen(),
    );
  }
}

/// Only for development SSL issues.
/// Remove in production.
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}