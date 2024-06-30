import 'package:dartz/dartz.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/repositories/anime_repository.dart';
import 'package:wibu_app/domain/usecases/usecase_failure.dart';

class FetchTopAnime {
  final AnimeRepository repository;

  FetchTopAnime(this.repository);

  Future<Either<Failure, List<Anime>>> call() async {
    return await repository.fetchTopAnime();
  }
}