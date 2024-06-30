import 'package:flutter/material.dart';
import 'package:wibu_app/domain/entities/anime.dart';

class AnimeDetailViewModel extends ChangeNotifier {
  final Anime anime;

  AnimeDetailViewModel({required this.anime});
}