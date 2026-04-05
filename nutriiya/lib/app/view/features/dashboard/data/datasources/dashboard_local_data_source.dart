// // data/datasources/movie_local_datasource.dart
//
// import 'dart:convert';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../model/movie_detail_model.dart';
// import '../model/movie_model.dart';
//
// abstract class MovieLocalDataSource {
//   Future<bool> isCacheValid();
//
//   Future<List<MovieResponseModel>> getCachedMovies();
//   Future<void> cacheMovies(List<MovieResponseModel> movies);
//
//   Future<MovieDetailResponseModel?> getCachedDetail(String imdbID);
//   Future<void> cacheDetail(MovieDetailResponseModel detail);
// }
//
// class MovieLocalDataSourceImpl implements MovieLocalDataSource {
//
//   final SharedPreferences prefs;
//   static const _moviesKey    = 'cached_movies';
//   static const _cacheDateKey = 'cache_date';
//   static const _detailPrefix = 'detail_';
//
//   MovieLocalDataSourceImpl(this.prefs);
//
//   @override
//   Future<bool> isCacheValid() async {
//     final dateStr = prefs.getString(_cacheDateKey);
//     if (dateStr == null) return false;
//     final cacheDate = DateTime.parse(dateStr);
//     final now = DateTime.now();
//     return cacheDate.year  == now.year  &&
//         cacheDate.month == now.month &&
//         cacheDate.day   == now.day;
//   }
//
//   @override
//   Future<List<MovieResponseModel>> getCachedMovies() async {
//     try {
//       final data = prefs.getString(_moviesKey);
//       if (data == null) return [];
//       final List decoded = jsonDecode(data);
//       return decoded.map((e) => MovieResponseModel.fromJson(e)).toList();
//     } catch (e) {
//       return [];
//     }
//   }
//
//   @override
//   Future<void> cacheMovies(List<MovieResponseModel> movies) async {
//     final encoded = jsonEncode(
//       movies.map((m) => m.toJson()).toList(),
//     );
//     await prefs.setString(_moviesKey, encoded);
//     await prefs.setString(
//       _cacheDateKey,
//       DateTime.now().toIso8601String(),
//     );
//   }
//
//   @override
//   Future<MovieDetailResponseModel?> getCachedDetail(String imdbID) async {
//     try {
//       final data = prefs.getString('$_detailPrefix$imdbID');
//       if (data == null) return null;
//       return MovieDetailResponseModel.fromJson(jsonDecode(data));
//     } catch (e) {
//       return null;
//     }
//   }
//
//   @override
//   Future<void> cacheDetail(MovieDetailResponseModel detail) async {
//     await prefs.setString(
//       '$_detailPrefix${detail.imdbId}',
//       jsonEncode(detail.toJson()),
//     );
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/constants/api_constants.dart';
import '../model/movie_model.dart';

class MovieRemoteDataSource {
  Future<MovieResponseModel> getMovies({
    required int page,
    required String query,
  }) async {
    final url = Uri.parse(
      "${ApiConstants.baseUrl}?s=$query&page=$page&apikey=${ApiConstants.apiKey}",
    );

    final response = await http.get(url);
    final decoded = json.decode(response.body);

    if (response.statusCode != 200) {
      throw Exception("Server error");
    }

    if (decoded["Response"] != "True") {
      throw Exception(decoded["Error"]);
    }

    return MovieResponseModel.fromJson(decoded);
  }
}
