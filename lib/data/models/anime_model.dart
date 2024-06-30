import 'package:wibu_app/domain/entities/anime.dart';

class AnimeModel {
  final int malId;
  final String title;
  final String imageUrl;
  final String synopsis;
  final double score;
  final String status;
  final int episodes;
  final List<String> genres;
  final List<String> studios;
  final String? trailerUrl;

  AnimeModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    required this.score,
    required this.status,
    required this.episodes,
    required this.genres,
    required this.studios,
    this.trailerUrl,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['images']['jpg']['image_url'],
      synopsis: json['synopsis'] ?? 'No synopsis available.',
      score: (json['score'] ?? 0).toDouble(),
      status: json['status'] ?? 'Unknown',
      episodes: json['episodes'] ?? 0,
      genres: (json['genres'] as List).map((genre) => genre['name'] as String).toList(),
      studios: (json['studios'] as List).map((studio) => studio['name'] as String).toList(),
      trailerUrl: json['trailer']['url'],
    );
  }

  Anime toEntity() {
    return Anime(
      malId: malId,
      title: title,
      imageUrl: imageUrl,
      synopsis: synopsis,
      score: score,
      status: status,
      episodes: episodes,
      genres: genres,
      studios: studios,
      trailerUrl: trailerUrl,
    );
  }
}