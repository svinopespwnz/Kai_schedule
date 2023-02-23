import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:kai_schedule/bloc/kai_vk_news_events.dart';
import 'package:kai_schedule/bloc/kai_vk_news_state.dart';
import '../repository/repository.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class KaiVkNewsBloc extends Bloc<PostEvent, KaiVkNewsState> {
  final ApiRepository _apiRepository;
  KaiVkNewsBloc(this._apiRepository) : super(KaiVkNewsState()) {
    on<PostFetched>(_getPosts,
        transformer: throttleDroppable(throttleDuration));
  }
  Future<void> _getPosts(
      PostFetched event, Emitter<KaiVkNewsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      final wall = await _apiRepository.getWall(state.data.length);
      final posts = wall.response?.items;
      emit(posts!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              hasReachedMax: false,
              data: List.of(state.data)..addAll(posts)));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
