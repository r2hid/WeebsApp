import 'package:dartz/dartz.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/usecases/usecase_failure.dart';
import 'package:wibu_app/domain/repositories/anime_repository.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<Anime>>> searchAnime(String query);
  Future<Either<Failure, List<Anime>>> fetchTopAnime();
  Future<List<Anime>> fetchRandomAnime({int maxAnime = 100});
}