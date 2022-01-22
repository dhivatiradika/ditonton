import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchListPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Movies',
              ),
              Tab(
                text: 'TV Series',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTVsPage(),
          ],
        ),
      ),
    );
  }
}

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(FetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return MovieCard(movie);
              },
              itemCount: state.movies.length,
            );
          } else if (state is WatchlistMovieError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class WatchlistTVsPage extends StatefulWidget {
  @override
  _WatchlistTVsPageState createState() => _WatchlistTVsPageState();
}

class _WatchlistTVsPageState extends State<WatchlistTVsPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvBloc>().add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvBloc>().add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          if (state is WatchlistTvLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.tvs[index];
                return TVCard(tv);
              },
              itemCount: state.tvs.length,
            );
          } else if (state is WatchlistTvError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
