import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:prak9/pages/movie_detail.dart';
import 'package:prak9/service/http_service.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
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

  String imgPath = 'https://image.tmdb.org/t/p/w500';

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
        title: Text("Popular Movies",
            style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
      ),
      body: ListView.builder(
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          itemBuilder: (context, int position) {
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
                title: Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: ClipRRect(
                          child: Image.network(
                            imgPath + movies[position].posterPath,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              movies[position].title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 12,
                                ),
                                Text(" " +
                                    movies[position].voteAverage.toString()),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
