import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Presentation
import 'app/view/features/dashboard/data/datasources/dasboard_data_source.dart';
import 'app/view/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'app/view/features/dashboard/data/repository/dashboard_repositoryimpl.dart';
import 'app/view/features/dashboard/domain/usecase/dashboard_usecase.dart';
import 'app/view/features/dashboard/presentation/page/dashboard_page.dart';
import 'app/view/features/dashboard/presentation/view_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({required this.prefs});
  @override
  Widget build(BuildContext context) {
    final remoteDataSource = DashboardDataSourceImpl();
    final localDataSource = MovieRemoteDataSource();

    final repository = MovieRepositoryImpl(
      remoteDataSource,
    );

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
        home: HomeScreen(),
      ),
    );
  }
}