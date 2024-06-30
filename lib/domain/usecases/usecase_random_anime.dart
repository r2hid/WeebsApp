import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/repositories/anime_repository.dart';

class FetchRandomAnime {
  final AnimeRepository repository;

  FetchRandomAnime(this.repository);

  Future<List<Anime>> call({int maxAnime = 100}) async {
    return await repository.fetchRandomAnime(maxAnime: maxAnime);
  }
}