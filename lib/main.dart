import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:wibu_app/presentation/viewmodels/user_viewmodel.dart';
import 'package:wibu_app/presentation/viewmodels/top_anime_viewmodel.dart';
import 'package:wibu_app/presentation/viewmodels/explore_viewmodel.dart';
import 'package:wibu_app/presentation/viewmodels/random_anime_viewmodel.dart';
import 'package:wibu_app/presentation/pages/login_page.dart';
import 'package:wibu_app/presentation/pages/main_page.dart';
import 'package:wibu_app/data/repositories/anime_repository_impl.dart';
import 'package:wibu_app/data/sources/anime_api_service.dart';
import 'package:wibu_app/domain/usecases/usecase_top_anime.dart';
import 'package:wibu_app/domain/usecases/usecase_search_anime.dart';
import 'package:wibu_app/domain/usecases/usecase_random_anime.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();
    final apiService = AnimeApiService();
    final animeRepository = AnimeRepositoryImpl(httpClient, apiService);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(
          create: (_) => TopAnimeViewModel(FetchTopAnime(animeRepository)),
        ),
        ChangeNotifierProvider(
          create: (_) => ExploreViewModel(SearchAnime(animeRepository)),
        ),
        ChangeNotifierProvider(
          create: (_) => RandomAnimeViewModel(FetchRandomAnime(animeRepository)),
        ),
      ],
      child: MaterialApp(
        title: 'Weebs App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<UserViewModel>(
          builder: (context, userViewModel, child) {
            if (userViewModel.user != null) {
              return MainPage();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}