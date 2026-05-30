import 'package:animelitz/providers/anime_provider.dart';
import 'package:animelitz/screens/anime_details_Screen.dart';
import 'package:animelitz/widgets/anime_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final currentscroll = scrollController.position.pixels;

      final maxscroll = scrollController.position.maxScrollExtent;

      if (currentscroll >= maxscroll - 300) {
        ref.read(animeProvider.notifier).fetchNextPge();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(animeSearchProvider);

    final provider = query.isEmpty
        ? ref.watch(animeProvider)
        : ref.watch(seachAnimeProvider(query));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.movie_filter_rounded,
              color: Colors.deepPurpleAccent,
              size: 22,
            ),
            SizedBox(width: 8),
            Text(
              'anime world',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(height: 1, color: Colors.white.withOpacity(0.08)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: 690,
            child: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search anime...',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              onSubmitted: (value) {
                final query = value.trim();

                if (query.isEmpty) {
                  ref.read(animeSearchProvider.notifier).state = '';
                  return;
                }

                ref.read(animeSearchProvider.notifier).state = query;
              },
            ),
          ),
          SizedBox(height: 30),

          Expanded(
            child: provider.when(
              data: (animelist) {
                return GridView.builder(
                  controller: scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: animelist.length,
                  itemBuilder: (context, index) {
                    final animevalue = animelist[index];

                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AnimeDetails(animeid: animevalue.malId),
                        ),
                      ),
                      child: AnimeCard(anime: animevalue),
                    );
                  },
                );
              },
              error: (error, stack) => Center(child: Text(error.toString())),
              loading: () => Center(child: const CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
