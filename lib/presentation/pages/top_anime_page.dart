import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/viewmodels/top_anime_viewmodel.dart';
import 'package:wibu_app/presentation/pages/anime_detail_page.dart';

class TopAnimePage extends StatefulWidget {
  @override
  _TopAnimePageState createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopAnimeViewModel>(context, listen: false).getTopAnimes());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TopAnimeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Top Anime'),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.error != null
          ? Center(child: Text('Error: ${viewModel.error}'))
          : ListView.builder(
        itemCount: viewModel.animes?.length ?? 0,
        itemBuilder: (context, index) {
          final anime = viewModel.animes![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimeDetailPage(anime: anime),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: Image.network(anime.imageUrl, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Rating: ${anime.score}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            anime.synopsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}