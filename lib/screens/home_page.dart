import 'package:flutter/material.dart';
import 'package:movie_list_app/domain/models/movie.dart';
import '../view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Lista de Filmes'),
          centerTitle: true
      ),
      body: StreamBuilder<List<Movie>>(
        stream: viewModel.streamController.stream,
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
                    viewModel.getMovies();
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