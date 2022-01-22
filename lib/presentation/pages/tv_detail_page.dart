import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_episode_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_recommendations_bloc.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';

  final int id;
  TVDetailPage({required this.id});

  @override
  _TVDetailPageState createState() => _TVDetailPageState();
}

class _TVDetailPageState extends State<TVDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
      context
          .read<TvRecommendationsBloc>()
          .add(FetchTvRecommendations(widget.id));
      context.read<WatchlistTvBloc>().add(LoadWatchlistTvStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.tvDetail;
            return SafeArea(
              child: DetailContent(tv),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVDetail tv;

  DetailContent(this.tv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (state is IsAddedToWatchListTv) {
                                      if (!state.isAdded) {
                                        context
                                            .read<WatchlistTvBloc>()
                                            .add(AddWatchListTv(tv));
                                      } else {
                                        context
                                            .read<WatchlistTvBloc>()
                                            .add(RemoveFromWatchListTv(tv));
                                      }
                                    }

                                    String message = "";
                                    if (state is IsAddedToWatchListTv) {
                                      final isAdded = state.isAdded;
                                      message = isAdded == false
                                          ? watchlistAddSuccessMessage
                                          : watchlistRemoveSuccessMessage;
                                    }

                                    if (message == watchlistAddSuccessMessage ||
                                        message ==
                                            watchlistRemoveSuccessMessage) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(message)));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(message),
                                            );
                                          });
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state is IsAddedToWatchListTv
                                          ? (state.isAdded
                                              ? Icon(Icons.check)
                                              : Icon(Icons.add))
                                          : Container(),
                                      Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Text(
                              tv.firstAirDate,
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            EpisodeViewer(tv: tv),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationsBloc,
                                TvRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvRecommendationsLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is TvRecommendationsHasError) {
                                  return Text(state.message);
                                } else if (state is TvRecommendationsHasData) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = state.tvs[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVDetailPage.ROUTE_NAME,
                                                arguments: tv.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: state.tvs.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class EpisodeViewer extends StatefulWidget {
  final TVDetail tv;
  const EpisodeViewer({Key? key, required this.tv}) : super(key: key);

  @override
  State<EpisodeViewer> createState() => _EpisodeViewerState();
}

class _EpisodeViewerState extends State<EpisodeViewer> {
  late Season _selectedSeason;

  @override
  void initState() {
    _selectedSeason = widget.tv.seasons[0];

    Future.microtask(
      () => context.read<TvEpisodeBloc>().add(
            FetchEpisodeDetail(widget.tv.id, _selectedSeason.seasonNumber, 1),
          ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<Season>(
          style: kHeading6,
          value: _selectedSeason,
          items: widget.tv.seasons.map(
            (value) {
              return DropdownMenuItem<Season>(
                value: value,
                child: Text(value.name),
              );
            },
          ).toList(),
          onChanged: (value) {
            setState(
              () {
                _selectedSeason = value ?? widget.tv.seasons[0];
              },
            );
          },
        ),
        BlocBuilder<TvEpisodeBloc, TvEpisodeState>(
          builder: (context, state) {
            if (state is TvEpisodeEmpty) {
              return Text('Episode no found.');
            } else if (state is TvEpisodeLoading) {
              return Text('Loading episode...');
            } else if (state is TvEpisodeHasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Episode ${state.tvEpisode.episodeNumber}: ${state.tvEpisode.name}'),
                  Text(state.tvEpisode.airDate ?? ''),
                ],
              );
            } else if (state is TvEpisodeError) {
              return Text(state.message);
            } else {
              return Container();
            }
          },
        ),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 8,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            for (int i = 1; i <= _selectedSeason.episodeCount; i++)
              InkWell(
                child: BlocBuilder<TvEpisodeBloc, TvEpisodeState>(
                  builder: (context, state) {
                    if (state is TvEpisodeHasData) {
                      return Container(
                        alignment: Alignment.center,
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(5),
                        child: Text(i.toString()),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: i == state.tvEpisode.episodeNumber
                              ? kMikadoYellow
                              : Colors.transparent,
                        ),
                      );
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        height: 10,
                        width: 10,
                        margin: EdgeInsets.all(5),
                        child: Text(i.toString()),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                      );
                    }
                  },
                ),
                onTap: () {
                  context.read<TvEpisodeBloc>().add(FetchEpisodeDetail(
                      widget.tv.id, _selectedSeason.seasonNumber, i));
                },
              ),
          ],
        )
      ],
    );
  }
}
