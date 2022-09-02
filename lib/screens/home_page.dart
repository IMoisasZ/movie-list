import 'package:flutter/material.dart';
import 'package:movie_list_app/domain/models/movie.dart';
import 'package:movie_list_app/services/movie_servie.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  MovieService service = MovieService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Filmes - ${service.currentPage}'),
          centerTitle: true
      ),
      body: StreamBuilder<List<Movie>>(
        stream: service.streamController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, position) {
                  if(position < snapshot.data!.length){
                    final movie = snapshot.data![position];
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600)
                        ),
                      ),
                      subtitle: Text(
                        movie.overview,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,),

                      leading: Image.network('https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                    );
                  }else {
                    service.loadMore();
                    return const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }


}