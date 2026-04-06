import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Presentation
import 'app/view/features/dashboard/data/datasources/dasboard_data_source.dart';
import 'app/view/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'app/view/features/dashboard/data/model/movie_model.dart';
import 'app/view/features/dashboard/data/repository/dashboard_repositoryimpl.dart';
import 'app/view/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'app/view/features/dashboard/presentation/page/dashboard_page.dart';
import 'app/view/features/dashboard/presentation/view_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(MovieResponseModelAdapter());
  Hive.registerAdapter(SearchAdapter());

  final box = await Hive.openBox('appBox');


  runApp(MyApp(box: box,));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
Box box;
   MyApp({required this.box});
  @override
  Widget build(BuildContext context) {
    final remoteDataSource = DashboardDataSourceImpl();
    final localDataSource = MovieRemoteDataSource(box);

    final repository = MovieRepositoryImpl(remoteDataSource,localDataSource);

    final getMoviesUseCase = GetMoviesUseCase(repository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieViewModel(getMoviesUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Feed App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DashboardScreen(),
      ),
    );
  }
}