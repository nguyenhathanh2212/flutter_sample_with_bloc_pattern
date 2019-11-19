import 'dart:async';
import 'package:cart_sample/src/models/trailer_model.dart';

import 'movie_api_provider.dart';
import '../models/item_model.dart';

class Repository {
  final movieApiProvider = MovieApiProvider();

  Future<ItemModel> fetchAllMovies(params) => movieApiProvider.fetchMovieList(params);

  Future<TrailerModel> fetchTraillers(int movieId) => movieApiProvider.fetchTrailers(movieId);
}
