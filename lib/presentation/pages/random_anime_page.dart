import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/viewmodels/random_anime_viewmodel.dart';
import 'package:wibu_app/presentation/pages/anime_detail_page.dart';

class RandomAnimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RandomAnimeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Random Anime Picker'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (viewModel.isLoading)
                  CircularProgressIndicator()
                else if (viewModel.error != null)
                  Text('Error: ${viewModel.error}')
                else if (viewModel.anime != null) ...[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnimeDetailPage(anime: viewModel.anime!),
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
                              child: Image.network(
                                viewModel.anime!.imageUrl,
                                fit: BoxFit.cover,
                                height: 300,
                                width: 200,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    viewModel.anime!.title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Rating: ${viewModel.anime!.score}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    viewModel.anime!.synopsis,
                                    style: TextStyle(
                                      fontSize: 14,
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
                  ],
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    viewModel.getRandomAnime();
                  },
                  child: Text('Randomize'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}