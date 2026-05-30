import 'package:animelitz/provider/animeprovider.dart';
import 'package:animelitz/screens/animedetailsScreen.dart';
import 'package:animelitz/widgets/animecard.dart';
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
      appBar: AppBar(title: Text('anime world'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 20),
          SizedBox(
            width: 250,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search),
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
