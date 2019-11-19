import '../resources/repository.dart';
//import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import 'dart:async';

class MoviesBloc {
//  final _repository = Repository();
//  final _moviesFetcher = PublishSubject<ItemModel>();
//
//  Observable<ItemModel> get allMovies => _moviesFetcher.stream;
//
//  fetchAllMovies(params) async {
//    ItemModel itemModel = await _repository.fetchAllMovies(params);
//    _moviesFetcher.sink.add(itemModel);
//  }
//
//  dispose() {
//    _moviesFetcher.close();
//  }

  final _repository = Repository();
  StreamController<ItemModel> _movieController = new StreamController<ItemModel>();
  Stream get getMovieStream => _movieController.stream;

  void fetchAllMovies(params) async {
    print(params);
    ItemModel itemModel = await _repository.fetchAllMovies(params);
    _movieController.sink.add(itemModel);
  }

  dispose() {
    _movieController.close();
  }
}

final moviesBloc = MoviesBloc();
