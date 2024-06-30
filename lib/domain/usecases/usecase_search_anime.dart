import 'package:dartz/dartz.dart';
import 'package:wibu_app/domain/repositories/anime_repository.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/usecases/usecase_failure.dart';

class SearchAnime {
  final AnimeRepository repository;

  SearchAnime(this.repository);

  Future<Either<Failure, List<Anime>>> execute(String query) {
    return repository.searchAnime(query);
  }
}