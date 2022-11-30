import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kai_schedule/bloc/lecturer_schedule_cubit.dart';
import 'package:kai_schedule/bloc/navigation_cubit.dart';
import 'package:kai_schedule/bloc/navigation_state.dart';
import 'package:kai_schedule/bloc/student_schedule_cubit.dart';
import 'package:kai_schedule/presentation/lecturer_schedule_screen.dart';
import 'package:kai_schedule/presentation/student_schedule_screen.dart';
import 'package:kai_schedule/schedule_repository/schedule_repository.dart';
import 'package:kai_schedule/utility/styles.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(scheduleRepository: ScheduleRepository()));
  // await ApiClient().getScore();
}

class MyApp extends StatelessWidget {
  final ScheduleRepository _scheduleRepository;
  const MyApp({Key? key, required scheduleRepository})
      : _scheduleRepository = scheduleRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _scheduleRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KAI Schedule',
        theme:
            ThemeData(primaryColor: Colors.black, primarySwatch: Colors.grey),
        home: BlocProvider(
            create: (context) => NavigationCubit(), child: const RootScreen()),
      ),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: context.read<NavigationCubit>().state.index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule), label: 'Расписание'),
            BottomNavigationBarItem(
                icon: Icon(Icons.school), label: 'Преподаватели')
          ],
          onTap: (index) {
            context.read<NavigationCubit>().getNavBarItem(index);
            _pageController.jumpToPage(index);
          },
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: AppStyles.selectedLabelStyle,
        );
      }),
      body: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            BlocProvider(
                create: (context) =>
                    StudentScheduleCubit(context.read<ScheduleRepository>()),
                child: const StudentScheduleScreen()),
            BlocProvider(
                create: (context) =>
                    LecturerScheduleCubit(context.read<ScheduleRepository>()),
                child: const LecturerScheduleScreen()),
          ],
        );
      }),
    );
  }
}
