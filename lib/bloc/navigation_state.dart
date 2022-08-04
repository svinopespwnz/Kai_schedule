class NavigationState {
  final int index;

  NavigationState( {required this.index});

  NavigationState copyWith({
    int? index,
  }) {
    return NavigationState(
     index: index ?? this.index,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationState &&
          runtimeType == other.runtimeType &&
          index == other.index;

  @override
  int get hashCode => index.hashCode;
}
