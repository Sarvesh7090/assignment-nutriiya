
import '../../domain/entity/movie_entity.dart';
import '../../domain/repositories/dasboard_repository.dart';
import '../datasources/dasboard_data_source.dart';
import '../datasources/dashboard_local_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DashboardDataSource remote;
  final MovieRemoteDataSource local;

  MovieRepositoryImpl(this.remote, this.local);

  Future<MovieEntity> getMovies({
    required int page,
    required String query,
    bool forceRefresh = false,
  }) async {

    final lastFetch = local.getLastFetchTime();

    final isExpired = lastFetch == null ||
        DateTime.now().difference(lastFetch).inHours >= 24;

    if (forceRefresh || isExpired) {

      print("🌐 Fetching from API");
      final remoteData = await remote.getMovies();
      await local.cacheData(remoteData);
      return remoteData.toEntity();
    } else {

      print("Loading from Hive");

      final localData = local.getData();

      if (localData != null) {
        return localData.toEntity();
      } else {
        throw Exception("No cached data available");
      }
    }
  }
}