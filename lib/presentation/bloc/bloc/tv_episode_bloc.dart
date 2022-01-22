import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_episode_detail.dart';
import 'package:equatable/equatable.dart';

part '../event/tv_episode_event.dart';
part '../state/tv_episode_state.dart';

class TvEpisodeBloc extends Bloc<TvEpisodeEvent, TvEpisodeState> {
  final GetEpisodeDetail _getEpisodeDetail;

  TvEpisodeBloc(this._getEpisodeDetail) : super(TvEpisodeEmpty()) {
    on<FetchEpisodeDetail>((event, emit) async {
      emit(TvEpisodeLoading());

      final result = await _getEpisodeDetail.execute(
          event.id, event.season, event.episode);

      result.fold(
        (failure) => emit(
          TvEpisodeError(failure.message),
        ),
        (data) => emit(
          TvEpisodeHasData(data),
        ),
      );
    });
  }
}
