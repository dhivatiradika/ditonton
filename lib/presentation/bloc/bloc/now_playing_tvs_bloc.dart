import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tvs.dart';
import 'package:equatable/equatable.dart';

part '../event/now_playing_tvs_event.dart';
part '../state/now_playing_tvs_state.dart';

class NowPlayingTvsBloc extends Bloc<NowPlayingTvsEvent, NowPlayingTvsState> {
  final GetNowPlayingTVs _getNowPlayingTVs;

  NowPlayingTvsBloc(this._getNowPlayingTVs) : super(NowPlayingTvsEmpty()) {
    on<FetchNowPlayingTvs>((event, emit) async {
      emit(NowPlayingTvsLoading());

      final result = await _getNowPlayingTVs.execute();

      result.fold(
        (failure) => emit(
          NowPlayingTvsError(failure.message),
        ),
        (data) => emit(
          NowPlayingTvsHasData(data),
        ),
      );
    });
  }
}
