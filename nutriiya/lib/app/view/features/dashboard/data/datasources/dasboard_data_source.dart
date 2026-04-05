import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_model.dart';
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_request_model.dart';

import '../../../../../core/constants/api_constants.dart';

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
    print("enter in data source 1");
    try {
      print("enter in data source 2");

      final url = Uri.parse(
        "${ApiConstants.baseUrl}?s=$query&page=$page&apikey=${ApiConstants.apiKey}",
      );

      print("enter in data source 3");

      final response = await http.get(url);
      final decoded = json.decode(response.body);

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      if (response.statusCode == 200) {
        if (decoded["Response"] == "True") {
          return MovieResponseModel.fromJson(decoded);
        } else {
          throw Exception(decoded["Error"] ?? "No data found");
        }
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }

    } catch (e) {
      print("❌ API ERROR: $e");
      throw Exception("API Failed: $e");
    }
  }
}