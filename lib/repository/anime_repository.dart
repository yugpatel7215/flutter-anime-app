import 'dart:convert';

import 'package:animelitz/models/anime_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AnimeRepository {
  Future<List<Anime>> fetchAnime(int page, int limit) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/top/anime?page=$page&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final List<dynamic> animeData = decodedData['data'];

      final animelist = animeData.map((e) => Anime.fromJson(e)).toList();

      return animelist;
    } else {
      throw Exception('no data found : ${response.statusCode}');
    }
  }

  Future<Anime> getAnimeDetails(int animeId) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/anime/$animeId'),
    );
    if (response.statusCode == 200) {
      final decodeddata = jsonDecode(response.body);

      final data = decodeddata['data'];

      final animedetails = Anime.fromJson(data);
      return animedetails;
    } else {
      throw Exception('no data found : ${response.statusCode}');
    }
  }

  Future<List<Anime>> getAnimeSeachedDetilas(String query) async {
    final response = await http.get(
      Uri.parse('https://api.jikan.moe/v4/anime?q=$query'),
    );
    if (response.statusCode == 200) {
      final decodeddata = jsonDecode(response.body);

      final List data = decodeddata['data'];

      final animedetails = data.map((e) => Anime.fromJson(e)).toList();

      return animedetails;
    } else {
      throw Exception('no data found : ${response.statusCode}');
    }
  }
}

final animeRepoProvider = Provider((ref) {
  return AnimeRepository();
});
