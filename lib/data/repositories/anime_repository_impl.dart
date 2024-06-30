import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:wibu_app/data/models/anime_model.dart';
import 'package:wibu_app/domain/entities/anime.dart';
import 'package:wibu_app/domain/repositories/anime_repository.dart';
import 'package:wibu_app/domain/usecases/usecase_failure.dart';
import 'package:wibu_app/data/sources/anime_api_service.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final http.Client client;
  final AnimeApiService apiService;

  AnimeRepositoryImpl(this.client, this.apiService);

  @override
  Future<Either<Failure, List<Anime>>> searchAnime(String query) async {
    try {
      final response = await client.get(Uri.parse('https://api.jikan.moe/v4/anime?q=$query'));

      if (response.statusCode == 200) {
        final List parsed = json.decode(response.body)['data'];
        return Right(parsed.map((anime) => AnimeModel.fromJson(anime).toEntity()).toList());
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Anime>>> fetchTopAnime() async {
    try {
      final response = await client.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

      if (response.statusCode == 200) {
        final List parsed = json.decode(response.body)['data'];
        return Right(parsed.map((anime) => AnimeModel.fromJson(anime).toEntity()).toList());
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<List<Anime>> fetchRandomAnime({int maxAnime = 100}) async {
    try {
      final animeModels = await apiService.fetchRandomAnime(maxAnime: maxAnime);
      return animeModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load random anime');
    }
  }
}