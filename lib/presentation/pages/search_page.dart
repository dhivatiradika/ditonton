import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_search_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final int tabIndex;

  SearchPage({required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    bool isMovies = tabIndex == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search ${isMovies ? 'Movies' : 'TV Series'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                isMovies
                    ? context
                        .read<MovieSearchBloc>()
                        .add(OnQueryMovieChanged(query))
                    : context.read<TvSearchBloc>().add(OnQueryTvChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            isMovies
                ? BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) {
                      if (state is MovieSearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieSearchHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final movie = result[index];
                              return MovieCard(movie);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  )
                : BlocBuilder<TvSearchBloc, TvSearchState>(
                    builder: (context, state) {
                      if (state is TvSearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is TvSearchHasData) {
                        final result = state.result;
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (context, index) {
                              final tv = result[index];
                              return TVCard(tv);
                            },
                            itemCount: result.length,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        );
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
