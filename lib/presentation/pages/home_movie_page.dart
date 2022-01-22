import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/now_playing_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_tvs_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/top_rated_tvs_page.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/widgets/sub_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMoviesBloc>().add(FetchNowPlayingMovies());
      context.read<PopularMoviesBloc>().add(FetchPopularMovies());
      context.read<TopRatedMoviesBloc>().add(FetchTopRatedMovies());

      context.read<NowPlayingTvsBloc>().add(FetchNowPlayingTvs());
      context.read<PopularTvsBloc>().add(FetchPopularTvs());
      context.read<TopRatedTvsBloc>().add(FetchTopRatedTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              drawer: Drawer(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage('assets/circle-g.png'),
                      ),
                      accountName: Text('Ditonton'),
                      accountEmail: Text('ditonton@dicoding.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.movie),
                      title: Text('Movies'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.save_alt),
                      title: Text('Watchlist'),
                      onTap: () {
                        Navigator.pushNamed(context, WatchListPage.ROUTE_NAME);
                      },
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                      },
                      leading: Icon(Icons.info_outline),
                      title: Text('About'),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'Movies'),
                    Tab(text: 'TV Series'),
                  ],
                ),
                title: Text('Ditonton'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SearchPage.ROUTE_NAME,
                        arguments: DefaultTabController.of(context)?.index,
                      );
                    },
                    icon: Icon(Icons.search),
                  )
                ],
              ),
              body: TabBarView(
                children: [
                  MovieSection(),
                  TVSection(),
                ],
              ),
            );
          },
        ));
  }
}

class MovieSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingMoviesBloc, NowPlayingMoviesState>(
              builder: (context, state) {
                if (state is NowPlayingMoviesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingMoviesHasData) {
                  return MovieList(state.movies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
              builder: (context, state) {
                if (state is PopularMoviesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMoviesHasData) {
                  return MovieList(state.movies);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
              builder: (context, state) {
                if (state is TopRatedMoviesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMoviesHasData) {
                  return MovieList(state.movies);
                } else {
                  return Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TVSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<NowPlayingTvsBloc, NowPlayingTvsState>(
              builder: (context, state) {
                if (state is NowPlayingTvsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingTvsHasData) {
                  return TVList(state.tvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTVsPage.ROUTE_NAME),
            ),
            BlocBuilder<PopularTvsBloc, PopularTvsState>(
              builder: (context, state) {
                if (state is PopularTvsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvsHasData) {
                  return TVList(state.tvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
            SubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTVsPage.ROUTE_NAME),
            ),
            BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
              builder: (context, state) {
                if (state is TopRatedTvsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvsHasData) {
                  return TVList(state.tvs);
                } else {
                  return Text('Failed');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TVList extends StatelessWidget {
  final List<TV> tvs;

  TVList(this.tvs);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvs[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
