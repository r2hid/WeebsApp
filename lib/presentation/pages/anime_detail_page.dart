import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wibu_app/domain/entities/anime.dart';

class AnimeDetailPage extends StatefulWidget {
  final Anime anime;

  AnimeDetailPage({required this.anime});

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    if (WebView.platform is SurfaceAndroidWebView) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  String _getYoutubeEmbedUrl(String url) {
    final Uri uri = Uri.parse(url);
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      final videoId = uri.queryParameters['v'] ?? uri.pathSegments.last;
      return 'https://www.youtube.com/embed/$videoId';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anime.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(widget.anime.imageUrl),
              ),
              SizedBox(height: 16),
              Text(
                widget.anime.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 16.0,
                runSpacing: 8.0,
                children: [
                  Text(
                    'Rating: ${widget.anime.score}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    'Status: ${widget.anime.status}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Text(
                    'Episodes: ${widget.anime.episodes}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Genres:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.anime.genres
                    .map((genre) => Chip(
                  label: Text(genre),
                ))
                    .toList(),
              ),
              SizedBox(height: 16),
              Text(
                'Studios:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.anime.studios
                    .map((studio) => Chip(
                  label: Text(studio),
                ))
                    .toList(),
              ),
              SizedBox(height: 16),
              if (widget.anime.trailerUrl != null && widget.anime.trailerUrl!.isNotEmpty) ...[
                Text(
                  'Trailer:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: WebView(
                    initialUrl: _getYoutubeEmbedUrl(widget.anime.trailerUrl!),
                    javascriptMode: JavascriptMode.unrestricted,
                    initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
                    allowsInlineMediaPlayback: true,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller = webViewController;
                    },
                  ),
                ),
                SizedBox(height: 16),
              ],
              Text(
                widget.anime.synopsis,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}