import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_model.dart';
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_request_model.dart';

abstract class DashboardDataSource{
  Future<MovieResponseModel> getMovies({
    required int page,
    required String query,});
}
class DashboardDataSourceImpl extends DashboardDataSource {
  @override
  Future<MovieResponseModel> getMovies({
    required int page,
    required String query,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://www.omdbapi.com/?s=$query&page=$page&apikey=25ccdd26",
        ),
      );

      final decoded = json.decode(response.body);

      if (response.statusCode == 200) {
        if (decoded["Response"] == "True") {
          return MovieResponseModel.fromJson(decoded);
        } else {
          throw Exception(decoded["Error"] ?? "No data found");
        }
      } else {
        // ✅ HANDLE THIS CASE (IMPORTANT)
        throw Exception("Server error: ${response.statusCode}");
      }

    } catch (e) {
      throw Exception("failed to load data inside catch: ${e.toString()}");
    }
  }
}