import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tvs.dart';
import 'package:equatable/equatable.dart';

part '../event/popular_tvs_event.dart';
part '../state/popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTVs _getPopularTVs;

  PopularTvsBloc(this._getPopularTVs) : super(PopularTvsEmpty()) {
    on<FetchPopularTvs>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await _getPopularTVs.execute();

      result.fold(
        (failure) => emit(
          PopularTvsError(failure.message),
        ),
        (data) => emit(
          PopularTvsHasData(data),
        ),
      );
    });
  }
}
