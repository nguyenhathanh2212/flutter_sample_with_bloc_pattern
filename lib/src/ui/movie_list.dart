import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/movies_bloc.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int _page = 1;

  @override
  void initState() {
    moviesBloc.fetchAllMovies({'page': _page});
    super.initState();
  }

  @override
  void dispose() {
    print('ahihi');
    moviesBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Popular Movies'
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: moviesBloc.getMovieStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildList(snapshot);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (_page > 1) moviesBloc.fetchAllMovies({'page': _page --});
                    });
                  },
                  textColor: Colors.red,
                  color: Colors.white70,
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    moviesBloc.fetchAllMovies({'page': _page ++});
                    print(_page);
                  },
                  textColor: Colors.red,
                  color: Colors.white70,
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Widget buildList(snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GridTile(
          child: InkResponse(
            enableFeedback: true,
            child: Container(
              margin: EdgeInsets.all(5.0),
              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: 'image-preview-${snapshot.data.results[index].id}',
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].poster_path}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            onTap: () => openDetailPage(snapshot.data, index),
          ),
        );
      }
    );
  }

  void openDetailPage(ItemModel itemModel, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovieDetail(
            title: itemModel.results[index].title,
            description: itemModel.results[index].overview,
            posterUrl: itemModel.results[index].poster_path,
            releaseDate: itemModel.results[index].release_date,
            voteAverage: itemModel.results[index].vote_average.toString(),
            movieId: itemModel.results[index].id,
          );
        }
      )
    );
  }
}
