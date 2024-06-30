import 'package:flutter/material.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/usecases/usecase_top_anime.dart';

class TopAnimeViewModel extends ChangeNotifier {
  final FetchTopAnime fetchTopAnimeUseCase;
  List<Anime>? animes;
  bool isLoading = false;
  String? error;

  TopAnimeViewModel(this.fetchTopAnimeUseCase);

  Future<void> getTopAnimes() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await fetchTopAnimeUseCase.call();

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