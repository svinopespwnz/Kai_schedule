import 'package:kai_schedule/models/wall_post.dart';

class KaiVkNewsState {
  final List<Items> data;

  KaiVkNewsState({List<Items>? data}) : data = data ?? [];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KaiVkNewsState &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}
