import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTVs mockGetWatchlistTvs;
  late MockGetTVWatchListStatus mockGetTVWatchListStatus;
  late MockSaveTVWatchlist mockSaveTVWatchlist;
  late MockRemoveTVWatchlist mockRemoveTVWatchlist;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTVs();
    mockGetTVWatchListStatus = MockGetTVWatchListStatus();
    mockSaveTVWatchlist = MockSaveTVWatchlist();
    mockRemoveTVWatchlist = MockRemoveTVWatchlist();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTvs,
        mockGetTVWatchListStatus, mockSaveTVWatchlist, mockRemoveTVWatchlist);
  });

  tearDown(() {
    watchlistTvBloc.close();
  });

  test('initial state should be empty', () {
    expect(watchlistTvBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTVList));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when data unsuccessfully loaded',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return message when data added',
    build: () {
      when(mockSaveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(AddWatchListTv(testTVDetail)),
    expect: () => [IsAddedToWatchListTv(true, 'Added to Watchlist')],
    verify: (bloc) {
      verify(mockSaveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return failure message when data added',
    build: () {
      when(mockSaveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(AddWatchListTv(testTVDetail)),
    expect: () => [IsAddedToWatchListTv(false, 'Server Failure')],
    verify: (bloc) {
      verify(mockSaveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return message when data removed',
    build: () {
      when(mockRemoveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Right('Removed to Watchlist'));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchListTv(testTVDetail)),
    expect: () => [IsAddedToWatchListTv(false, 'Removed to Watchlist')],
    verify: (bloc) {
      verify(mockRemoveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return failure message when data removed',
    build: () {
      when(mockRemoveTVWatchlist.execute(testTVDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchListTv(testTVDetail)),
    expect: () => [IsAddedToWatchListTv(true, 'Server Failure')],
    verify: (bloc) {
      verify(mockRemoveTVWatchlist.execute(testTVDetail));
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should return true when status loaded',
    build: () {
      when(mockGetTVWatchListStatus.execute(1)).thenAnswer((_) async => true);
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistTvStatus(1)),
    expect: () => [IsAddedToWatchListTv(true, '')],
    verify: (bloc) {
      verify(mockGetTVWatchListStatus.execute(1));
    },
  );
}
