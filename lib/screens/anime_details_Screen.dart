import 'package:animelitz/models/animemodel.dart';
import 'package:animelitz/provider/animeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animelitz/widgets/stat_badge.dart';

class AnimeDetails extends ConsumerWidget {
  final int animeid;
  const AnimeDetails({super.key, required this.animeid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animedetails = ref.watch(animeDetailProvider(animeid));

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: animedetails.when(
        data: (anime) => _AnimeDetailsContent(anime: anime),
        error: (error, stack) => Center(
          child: Text(
            error.toString(),
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFFE040FB)),
        ),
      ),
    );
  }
}

class _AnimeDetailsContent extends StatelessWidget {
  final Anime anime;
  const _AnimeDetailsContent({required this.anime});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // ── Hero AppBar with cover image ──
        SliverAppBar(
          expandedHeight: 380,
          pinned: true,
          backgroundColor: const Color(0xFF0D0D1A),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(anime.imageUrl, fit: BoxFit.cover),
                // Gradient overlay so text is readable
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xFF0D0D1A)],
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // ── Content ──
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  anime.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),

                // Stats row
                Row(
                  children: [
                    StatBadge(
                      icon: Icons.star_rounded,
                      label: anime.score.toString(),
                      color: const Color(0xFFFFD700),
                    ),
                    const SizedBox(width: 12),
                    StatBadge(
                      icon: Icons.play_circle_outline_rounded,
                      label: '${anime.episodes} eps',
                      color: const Color(0xFF64B5F6),
                    ),
                    const SizedBox(width: 12),
                    StatBadge(
                      icon: Icons.leaderboard_rounded,
                      label: '#${anime.rank}',
                      color: const Color(0xFFE040FB),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Divider
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFE040FB), Colors.transparent],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Synopsis heading
                const Text(
                  'Synopsis',
                  style: TextStyle(
                    color: Color(0xFFE040FB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),

                // Synopsis body
                Text(
                  anime.synopsis,
                  style: const TextStyle(
                    color: Color(0xFFB0B0C8),
                    fontSize: 14.5,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Reusable stat badge ──
