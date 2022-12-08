import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news_state.dart';

import '../models/wall_post.dart';
import '../repository/repository.dart';

class KaiVkNewsCubit extends Cubit<KaiVkNewsState> {
  final ApiRepository _apiRepository;
  KaiVkNewsCubit(this._apiRepository) : super(KaiVkNewsState());
  Future<void> getWall() async {
    final wall = await _apiRepository.getWall();
    final List<Items>? posts = wall.response?.items;
    emit(KaiVkNewsState(data: posts));
  }
}
