import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutriiya/app/global/model/use_case_request_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../provider/movie_provider.dart';
import '../widget/bottom_sheet_detail.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends ConsumerState<DashboardScreen> {
  ScrollController controller = ScrollController();
  int pageNumber = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener((){
      if(controller.position.pixels >= controller.position.maxScrollExtent - 100){
        print("enter in pagination api call");
        ref.read(movieProvider.notifier).loadMore();
      }
    });
    Future.microtask(() {
      ref.read(movieProvider.notifier).loadMovies(param: UseCaseRequestModel(query: {
        "s" : "batman",
        "page" : "1",
        "apiKey" : ApiConstants.apiKey
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(movieProvider.notifier).loadMovies(param: UseCaseRequestModel(query: {
                "s" : "batman",
                "page" : "1",
                "apiKey" : ApiConstants.apiKey
              }));
            },
          )
        ],
      ),

      body: Builder(
        builder: (_) {
          if (state.isLoading && state.movies.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null) {
            print("error state 51 ${state.error}");
            return Center(child: Text(state.error!));
          }

          if (state.movies.isEmpty) {
            return const Center(child: Text("No Movies Found"));
          }
          print("enter in dashboard page");
          return RefreshIndicator(
            onRefresh: () => ref.read(movieProvider.notifier).loadMovies(param: UseCaseRequestModel(query: {
              "s" : "batman",
              "page" : "1",
              "apiKey" : ApiConstants.apiKey
            })),
            child: ListView.builder(
              controller: controller,
              itemCount:   state.movies.length +
                  (state.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.movies.length) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final movie = state.movies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: true,
                        enableDrag: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return BottomSheetDetail(movie: movie);
                        },
                      );
                    },

                    leading: SizedBox(
                      width: 50,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.poster,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                        ),
                      ),
                    ),

                    title: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    subtitle: Text("Year: ${movie.year}"),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  )
                );
              },
            ),
          );
        },
      ),
    );
  }
}