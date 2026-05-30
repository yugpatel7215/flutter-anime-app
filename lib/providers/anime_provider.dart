import 'package:animelitz/models/anime_model.dart';
import 'package:animelitz/repository/anime_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final animeProvider = AsyncNotifierProvider<AnimeNotifier, List<Anime>>(
  AnimeNotifier.new,
);

final animeSearchProvider = StateProvider<String>((ref) {
  return '';
});

final filterAnimeListProvider = Provider<List<Anime>>((ref) {
  final searchValue = ref.watch(animeSearchProvider);

  final animeAsync = ref.watch(animeProvider);

  final animeList = animeAsync.value ?? [];

  if (searchValue.isEmpty) {
    return animeList;
  }

  return animeList.where((anime) {
    return anime.title.toLowerCase().contains(searchValue.toLowerCase().trim());
  }).toList();
});

final animeDetailProvider = FutureProvider.family<Anime, int>((
  ref,
  animeId,
) async {
  final repo = ref.read(animeRepoProvider);

  return repo.getAnimeDetails(animeId);
});

final seachAnimeProvider = FutureProvider.family<List<Anime>, String>((
  ref,
  query,
) async {
  final repo = ref.read(animeRepoProvider);
  return repo.getAnimeSeachedDetilas(query);
});

class AnimeNotifier extends AsyncNotifier<List<Anime>> {
  int currentPage = 1;

  final int limit = 12;

  bool hasMore = true;

  bool isLoadingMore = false;

  @override
  Future<List<Anime>> build() async {
    final repo = ref.read(animeRepoProvider);

    return await repo.fetchAnime(currentPage, limit);
  }

  Future<void> fetchNextPge() async {
    if (!hasMore || isLoadingMore) {
      return;
    }

    try {
      isLoadingMore = true;

      currentPage++;

      final repo = ref.read(animeRepoProvider);

      final previous = state.value ?? [];

      final nextPageData = await repo.fetchAnime(currentPage, limit);

      if (nextPageData.isEmpty) {
        hasMore = false;
      }

      state = AsyncData([...previous, ...nextPageData]);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    } finally {
      isLoadingMore = false;
    }
  }
}
