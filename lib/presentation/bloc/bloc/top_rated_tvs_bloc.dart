import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:equatable/equatable.dart';

part '../event/top_rated_tvs_event.dart';
part '../state/top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTVs _getTopRatedTVs;

  TopRatedTvsBloc(this._getTopRatedTVs) : super(TopRatedTvsEmpty()) {
    on<FetchTopRatedTvs>((event, emit) async {
      emit(TopRatedTvsLoading());

      final result = await _getTopRatedTVs.execute();

      result.fold(
        (failure) => emit(
          TopRatedTvsError(failure.message),
        ),
        (data) => emit(
          TopRatedTvsHasData(data),
        ),
      );
    });
  }
}
