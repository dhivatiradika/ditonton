import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late TvSearchBloc searchBloc;
  late MockSearchTVs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTVs();
    searchBloc = TvSearchBloc(mockSearchTvs);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(testTVDetail.name))
          .thenAnswer((_) async => Right(testTVList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChanged(testTVDetail.name)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchHasData(testTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(testTVDetail.name));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when data unsuccessful loaded',
    build: () {
      when(mockSearchTvs.execute(testTVDetail.name))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvChanged(testTVDetail.name)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(testTVDetail.name));
    },
  );
}
