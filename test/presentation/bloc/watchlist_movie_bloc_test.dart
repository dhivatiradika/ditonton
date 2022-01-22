import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies,
        mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

  tearDown(() {
    watchlistMovieBloc.close();
  });

  test('initial state should be empty', () {
    expect(watchlistMovieBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [Loading, HasData] when data unsuccessfully loaded',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return message when data added',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(AddWatchListMovie(testMovieDetail)),
    expect: () => [IsAddedToWatchListMovie(true, 'Added to Watchlist')],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return failure message when data added',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(AddWatchListMovie(testMovieDetail)),
    expect: () => [IsAddedToWatchListMovie(false, 'Server Failure')],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return message when data removed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed to Watchlist'));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchListMovie(testMovieDetail)),
    expect: () => [IsAddedToWatchListMovie(false, 'Removed to Watchlist')],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return failure message when data removed',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchListMovie(testMovieDetail)),
    expect: () => [IsAddedToWatchListMovie(true, 'Server Failure')],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should return true when status loaded',
    build: () {
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return watchlistMovieBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistMovieStatus(1)),
    expect: () => [IsAddedToWatchListMovie(true, '')],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(1));
    },
  );
}
