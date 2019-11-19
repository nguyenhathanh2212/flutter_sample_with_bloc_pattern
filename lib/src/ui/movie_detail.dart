import 'package:cart_sample/src/models/trailer_model.dart';
import 'package:flutter/material.dart';
import '../blocs/movie_detail_bloc.dart';

class MovieDetail extends StatefulWidget {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetail({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MovieDetailState(
      title: title,
      posterUrl: posterUrl,
      description: description,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      movieId: movieId,
    );
  }
}

class MovieDetailState extends State<MovieDetail> {
  final posterUrl;
  final description;
  final releaseDate;
  final String title;
  final String voteAverage;
  final int movieId;

  MovieDetailState({
    this.title,
    this.posterUrl,
    this.description,
    this.releaseDate,
    this.voteAverage,
    this.movieId,
  });

  @override
  void initState() {
    movieDetailBloc.fetchTrailerMovie(this.movieId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'image-preview-$movieId',
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500$posterUrl',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(top: 5.0),),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0),),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.red[500],
                      onPressed: () {

                      },
                    ),
                    Text(
                      voteAverage,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        releaseDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    )
                  ],
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0),),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0),),
                Text(
                  'Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0),),
                Expanded(
                  child: StreamBuilder(
                    stream: movieDetailBloc.getMovieDetailStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                            itemCount: snapshot.data.results.length,
                            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5.0),
                                    height: 100.0,
                                    color: Colors.grey,
                                    child: Center(child: Icon(Icons.play_circle_filled)),
                                  ),
                                  Text(
                                    snapshot.data.results[index].name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            }
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget trailerLayout(TrailerModel trailerModel) {
    if (trailerModel.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(trailerModel, 0),
          trailerItem(trailerModel, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(trailerModel, 0),
        ],
      );
    }
  }

  Widget trailerItem(TrailerModel trailerModel, int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 100.0,
            color: Colors.grey,
            child: Center(child: Icon(Icons.play_circle_filled)),
          ),
          Text(
            trailerModel.results[index].name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}