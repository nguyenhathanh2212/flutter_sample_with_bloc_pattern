import '../resources/repository.dart';
import '../models/trailer_model.dart';
import 'dart:async';

class MovieDetailBloc {

  final _repository = Repository();
  StreamController<TrailerModel> _movieDetailController = new StreamController<TrailerModel>.broadcast();
  Stream get getMovieDetailStream => _movieDetailController.stream;

  void fetchTrailerMovie(int movieId) async {
    TrailerModel trailerModel = await _repository.fetchTraillers(movieId);
    _movieDetailController.sink.add(trailerModel);
  }

  dispose() {
    _movieDetailController.close();
  }
}

final movieDetailBloc = MovieDetailBloc();
