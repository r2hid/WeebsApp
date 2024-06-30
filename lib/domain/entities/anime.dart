class Anime {
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

  Anime({
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
}