import 'package:kai_schedule/models/wall_post.dart';

enum PostStatus { init, success, failure }

class KaiVkNewsState {
  final List<Items> data;
  final PostStatus status;
  final bool hasReachedMax;
  KaiVkNewsState(
      {this.status = PostStatus.init,
      this.hasReachedMax = false,
      List<Items>? data})
      : data = data ?? [];

  KaiVkNewsState copyWith(
      {PostStatus? status, bool? hasReachedMax, List<Items>? data}) {
    return KaiVkNewsState(
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        data: data ?? this.data);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KaiVkNewsState &&
          runtimeType == other.runtimeType &&
          data == other.data &&
          status == other.status &&
          hasReachedMax == other.hasReachedMax;

  @override
  int get hashCode => data.hashCode ^ status.hashCode ^ hasReachedMax.hashCode;
}
