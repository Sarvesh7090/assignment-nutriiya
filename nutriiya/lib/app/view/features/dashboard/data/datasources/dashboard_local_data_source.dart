
import 'package:hive/hive.dart';
import '../model/movie_model.dart';

class MovieRemoteDataSource {
  final Box box;
  MovieRemoteDataSource(this.box);

  Future<void> cacheData(MovieResponseModel data) async {
    await box.put('movies', data);
    await box.put('last_fetch', DateTime.now().toIso8601String());
  }

  MovieResponseModel? getData() {
    return box.get('movies');
  }

  DateTime? getLastFetchTime() {
    final time = box.get('last_fetch');
    return time != null ? DateTime.parse(time) : null;
  }
}
