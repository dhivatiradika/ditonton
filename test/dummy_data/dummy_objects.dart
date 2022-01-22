import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTV = TV(
    backdropPath: '/sjx6zjQI2dLGtEL0HGWsnq6UyLU.jpg',
    firstAirDate: '2021-12-29',
    genreIds: [10765, 10759],
    id: 115036,
    name: 'The Book of Boba Fett',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'The Book of Boba Fett',
    overview:
        'Legendary bounty hunter Boba Fett and mercenary Fennec Shand must navigate the galaxys underworld when they return to the sands of Tatooine to stake their claim on the territory once ruled by Jabba the Hutt and his crime syndicate.',
    popularity: 2230.008,
    posterPath: '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
    voteAverage: 8.2,
    voteCount: 362);

final testMovieList = [testMovie];

final testTVList = [testTV];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTVDetail = TVDetail(
    adult: false,
    backdropPath: '/sjx6zjQI2dLGtEL0HGWsnq6UyLU.jpg',
    firstAirDate: '2021-12-29',
    genres: [Genre(id: 1, name: 'action')],
    id: 115036,
    lastAirDate: null,
    name: 'The Book of Boba Fett',
    originalName: 'The Book of Boba Fett',
    overview:
        'Legendary bounty hunter Boba Fett and mercenary Fennec Shand must navigate the galaxys underworld when they return to the sands of Tatooine to stake their claim on the territory once ruled by Jabba the Hutt and his crime syndicate.',
    popularity: 2230.008,
    posterPath: '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
    voteAverage: 8.2,
    voteCount: 13507,
    seasons: [
      Season(
          airDate: '2021-12-29',
          episodeCount: 8,
          id: 1,
          name: 'Seasin 1',
          overview: 'overview',
          posterPath: '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
          seasonNumber: 1)
    ]);

final testEpisodeDetail = TVEpisode(
    airDate: 'airDate',
    episodeNumber: 1,
    name: 'name',
    overview: 'overview',
    id: 1,
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchListTV = TV.watchList(
    id: 115036,
    overview:
        'Legendary bounty hunter Boba Fett and mercenary Fennec Shand must navigate the galaxys underworld when they return to the sands of Tatooine to stake their claim on the territory once ruled by Jabba the Hutt and his crime syndicate.',
    posterPath: '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
    name: 'The Book of Boba Fett');

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 115036,
  name: 'The Book of Boba Fett',
  posterPath: '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
  overview:
      'Legendary bounty hunter Boba Fett and mercenary Fennec Shand must navigate the galaxys underworld when they return to the sands of Tatooine to stake their claim on the territory once ruled by Jabba the Hutt and his crime syndicate.',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVMap = {
  'id': 115036,
  'name': 'The Book of Boba Fett',
  'posterPath': '/gNbdjDi1HamTCrfvM9JeA94bNi2.jpg',
  'overview':
      'Legendary bounty hunter Boba Fett and mercenary Fennec Shand must navigate the galaxys underworld when they return to the sands of Tatooine to stake their claim on the territory once ruled by Jabba the Hutt and his crime syndicate.'
};

final testTVEpisode = TVEpisode(
    airDate: '',
    episodeNumber: 1,
    name: 'name',
    overview: 'overview',
    id: 1,
    productionCode: 'productionCode',
    seasonNumber: 1,
    stillPath: 'stillPath',
    voteAverage: 1,
    voteCount: 1);
