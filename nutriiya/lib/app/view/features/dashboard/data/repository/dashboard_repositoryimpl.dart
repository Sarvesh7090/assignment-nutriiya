
import 'package:nutriiya/app/core/constants/api_constants.dart';
import 'package:nutriiya/app/global/model/use_case_request_model.dart';
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_model.dart';

import '../../domain/entity/movie_entity.dart';
import '../../domain/repositories/dasboard_repository.dart';
import '../datasources/dasboard_data_source.dart';
import '../datasources/dashboard_local_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DashboardDataSource remote;
  final MovieRemoteDataSource local;

  MovieRepositoryImpl(this.remote, this.local);

  Future<MovieEntity> getMovies({
    required UseCaseRequestModel param,
    bool forceRefresh = false,
  }) async {
    print("inside MovieRepositoryImpl");
    final lastFetch = local.getLastFetchTime();
    // print('time $lastFetch || ${DateTime.now().difference(lastFetch!).inHours}');
// final isExpired = true;
    final isExpired = lastFetch == null || DateTime.now().difference(lastFetch).inHours >= 24;
    print("isExpired $isExpired");
    if (forceRefresh || isExpired) {

      print("Fetching from API");
      // final remoteData = await remote.getMovies(param: param);
      List<Search> allMovies = [];
      for(int page = 1; page <= 4; page++){
        final data = await remote.getMovies(param: param);
        allMovies.addAll(data.search);
      }
      final fullData = MovieResponseModel(search: allMovies, totalResults: allMovies.length.toString(), response: "True");
      await local.cacheData(fullData);
      return fullData.toEntity();
    } else {

      print("Loading from Hive 1");

      final localData = local.getData();
      print("Loading from Hive 2 ${localData?.search}");
      if (localData != null) {
        return localData.toEntity();
      } else {
        throw Exception("No cached data available");
      }
    }
  }
}