import 'package:bloc/bloc.dart';
import 'package:kai_schedule/bloc/navigation/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState(index: 0));
  void getNavBarItem(int index) {
    emit(NavigationState(index: index));
  }
}
