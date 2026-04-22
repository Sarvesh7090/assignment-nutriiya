import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nutriiya/app/global/model/use_case_request_model.dart';
import 'package:nutriiya/app/view/features/dashboard/data/model/movie_model.dart';

import '../../../../../core/constants/api_constants.dart';

abstract class DashboardDataSource{
  Future<MovieResponseModel> getMovies({required UseCaseRequestModel param});
}
class DashboardDataSourceImpl extends DashboardDataSource {
  @override
  Future<MovieResponseModel> getMovies({required UseCaseRequestModel param}) async {
    print("enter in data source 1");
    // try {
    //   print("enter in data source 2");
    //
    //   final url = Uri.parse(
    //     "${ApiConstants.baseUrl}?",
    //   );
    //
    //   print("enter in data source 3 $url");
    //
    //   final response = await http.get(Uri.parse(
    //     "${ApiConstants.baseUrl}?",
    //   ).replace(queryParameters: param.query ?? {}));
    //   final decoded = json.decode(response.body);
    //
    //   print("STATUS: ${response.statusCode}");
    //   print("BODY: ${response.body}");
    //
    //   if (response.statusCode == 200) {
    //     if (decoded["Response"] == "True") {
    //       return MovieResponseModel.fromJson(decoded);
    //     } else {
    //       throw Exception(decoded["Error"] ?? "No data found");
    //     }
    //   } else {
    //     throw Exception("Server error: ${response.statusCode}");
    //   }
    //
    // } catch (e) {
    //   print("enter catch remote api call $e");
    //   throw Exception("API Failed: $e");
    // }
    try {
      final url = Uri.parse(ApiConstants.baseUrl).replace(
        queryParameters: param.query ?? {},
      );

      print("URL: $url");

      final response = await http.get(url);

      final decoded = json.decode(response.body);

      if (response.statusCode == 200) {
        if (decoded["Response"] == "True") {
          return MovieResponseModel.fromJson(decoded);
        } else {
          throw Exception(decoded["Error"]);
        }
      } else {
        throw Exception("Server error ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("API Failed: $e");
    }
  }
}