import 'package:flutter/material.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/usecases/usecase_random_anime.dart';

class RandomAnimeViewModel extends ChangeNotifier {
  final FetchRandomAnime fetchRandomAnime;

  RandomAnimeViewModel(this.fetchRandomAnime);

  Anime? _anime;
  String? _error;
  bool _isLoading = false;

  Anime? get anime => _anime;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> getRandomAnime() async {
    _isLoading = true;
    notifyListeners();

    try {
      final animes = await fetchRandomAnime.call(maxAnime: 100);
      print('Fetched ${animes.length} animes');
      _anime = (animes..shuffle()).first;
      _error = null;
    } catch (e) {
      print('Error fetching random anime: $e');
      _anime = null;
      _error = e.toString();
    }

    if (!hasListeners) return;  // Check if the object is disposed before calling notifyListeners
    _isLoading = false;
    notifyListeners();
  }
}