import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/bloc/bloc/tv_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/usecase_helper.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    tvDetailBloc = TvDetailBloc(mockGetTVDetail);
  });

  tearDown(() {
    tvDetailBloc.close();
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTVDetail.execute(1))
          .thenAnswer((_) async => Right(testTVDetail));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(testTVDetail),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(1));
    },
  );

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data unsuccessfully loaded',
    build: () {
      when(mockGetTVDetail.execute(1))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(1)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVDetail.execute(1));
    },
  );
}
