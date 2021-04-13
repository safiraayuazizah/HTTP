import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:prak9/pages/movie_detail.dart';
import 'package:prak9/service/http_service.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String imgPath = 'https://image.tmdb.org/t/p/w500/';
  int moviesCount;
  List movies;
  HttpService service;

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Movies",
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          itemBuilder: (context, int position) {
            // return Card(
            //   color: Colors.white,
            //   elevation: 2.0,
            //   child: ListTile(
            //     title: Text(movies[position].title),
            //     subtitle: Text(
            //       'Rating : ' + movies[position].voteAverage.toString(),
            //     ),
            //     onTap: () {
            //       MaterialPageRoute route = MaterialPageRoute(
            //           builder: (_) => MovieDetail(movies[position]));
            //       Navigator.push(context, route);
            //     },
            //   ),
            // );
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: InkWell(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          NetworkImage(imgPath + movies[position].posterPath),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
