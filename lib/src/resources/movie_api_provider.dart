import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  final _baseUrl = 'http://api.themoviedb.org/3/movie';

  Future<ItemModel> fetchMovieList(params) async {
    params['page'] = params.containsKey('page') ? params['page'] :  1;

    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey&page=${params['page']}");

//    print(response.body.toString());

    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get data from API');
    }
  }
  
  Future<TrailerModel> fetchTrailers(int movieId) async {
    final response = await client.get('$_baseUrl/$movieId/videos?api_key=$_apiKey');
    
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
