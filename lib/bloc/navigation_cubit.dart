import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(index: 0));
  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(NavigationState(index: index));
        break;
      case 1:
        emit(NavigationState(index: index));
        break;
    }
  }
}
