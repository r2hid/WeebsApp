import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/viewmodels/explore_viewmodel.dart';
import 'package:wibu_app/presentation/pages/anime_detail_page.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _searchAnime() {
    if (_searchController.text.isNotEmpty) {
      Provider.of<ExploreViewModel>(context, listen: false)
          .searchAnime(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ExploreViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Anime'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Anime...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) => _searchAnime(),
            ),
          ),
        ),
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.error != null
          ? Center(child: Text('Error: ${viewModel.error}'))
          : viewModel.animes == null
          ? Center(child: Text('Search for an anime to see results.'))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: viewModel.animes!.length,
        itemBuilder: (context, index) {
          final anime = viewModel.animes![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailPage(anime: anime),
                ),
              );
            },
            child: GridTile(
              child: Image.network(anime.imageUrl, fit: BoxFit.cover),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  anime.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}