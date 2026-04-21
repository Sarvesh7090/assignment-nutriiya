import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:nutriiya/app/view/features/dashboard/data/datasources/dashboard_local_data_source.dart';
import 'package:nutriiya/app/view/features/dashboard/presentation/provider/movie_controller.dart';
import 'package:nutriiya/app/view/features/dashboard/presentation/provider/movie_state.dart';

import '../../data/datasources/dasboard_data_source.dart';
import '../../data/repository/dashboard_repositoryimpl.dart';
import '../../domain/repositories/dasboard_repository.dart';
import '../../domain/usecase/dashboard_usecase.dart';

final remoteProvider =
Provider<DashboardDataSource>((ref) {
  return DashboardDataSourceImpl();
});

final localProvider =
Provider<MovieRemoteDataSource>((ref) {
  final box = Hive.box('movieBox');
  return MovieRemoteDataSource(box);
});



final repositoryProvider = Provider<MovieRepository>((ref){
  return MovieRepositoryImpl(
    ref.read(remoteProvider),
    ref.read(localProvider)
  );
});

final useCaseProvider = Provider<GetMoviesUseCase>((ref){
  return GetMoviesUseCase(ref.read(repositoryProvider));
});

final movieProvider = StateNotifierProvider<MovieController, MovieState>((ref){
  return MovieController(
    ref.read(useCaseProvider)
  );
});