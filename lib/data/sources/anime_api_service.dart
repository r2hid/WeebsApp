import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wibu_app/data/models/anime_model.dart';

class AnimeApiService {
  final String baseUrl = 'https://api.jikan.moe/v4';

  Future<List<AnimeModel>> fetchTopAnime() async {
    final response = await http.get(Uri.parse('$baseUrl/top/anime'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((anime) => AnimeModel.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to load top anime');
    }
  }

  Future<List<AnimeModel>> searchAnime(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/anime?q=$query'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((anime) => AnimeModel.fromJson(anime)).toList();
    } else {
      throw Exception('Failed to search anime');
    }
  }

  Future<List<AnimeModel>> fetchRandomAnime({int maxAnime = 100}) async {
    List<AnimeModel> allAnime = [];
    int currentPage = 1;
    bool hasNextPage = true;

    while (hasNextPage && allAnime.length < maxAnime) {
      final response = await http.get(Uri.parse('$baseUrl/top/anime?page=$currentPage'));
      print('Fetching page $currentPage');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List animeData = jsonResponse['data'];
        allAnime.addAll(animeData.map((anime) => AnimeModel.fromJson(anime)).toList());

        if (jsonResponse.containsKey('pagination')) {
          var pagination = jsonResponse['pagination'];
          if (pagination.containsKey('has_next_page')) {
            hasNextPage = pagination['has_next_page'];
          } else {
            hasNextPage = false;
          }
        } else {
          hasNextPage = false;
        }
        print('Has next page: $hasNextPage');
        currentPage++;
      } else {
        hasNextPage = false;
        print('Failed to load page $currentPage: ${response.body}');
        throw Exception('Failed to load anime: ${response.body}');
      }
    }

    if (allAnime.length > maxAnime) {
      allAnime = allAnime.sublist(0, maxAnime);
    }

    print('Fetched ${allAnime.length} animes');
    return allAnime;
  }
}