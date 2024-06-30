import 'package:flutter/material.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/usecases/usecase_search_anime.dart';

class ExploreViewModel extends ChangeNotifier {
  final SearchAnime searchAnimeUseCase;
  List<Anime>? animes;
  bool isLoading = false;
  String? error;

  ExploreViewModel(this.searchAnimeUseCase);

  Future<void> searchAnime(String query) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await searchAnimeUseCase.execute(query);

    result.fold(
          (failure) {
        error = failure.message;
      },
          (animes) {
        this.animes = animes;
      },
    );

    isLoading = false;
    notifyListeners();
  }
}