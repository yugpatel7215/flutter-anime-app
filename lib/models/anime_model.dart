class Anime {
  final int malId;
  final String title;
  final double score;
  final String imageUrl;
  final int? episodes;
  final int rank;
  final String synopsis;
  final String status;

  Anime({
    required this.malId,
    required this.title,
    required this.score,
    required this.imageUrl,
    required this.episodes,
    required this.rank,
    required this.synopsis,
    required this.status,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'] ?? 0,
      title: json['title'] ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      episodes: json['episodes'],
      rank: json['rank'] ?? 0,
      synopsis: json['synopsis'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
