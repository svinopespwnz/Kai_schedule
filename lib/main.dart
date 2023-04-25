import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news/kai_vk_news_bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news/kai_vk_news_events.dart';
import 'package:kai_schedule/bloc/lecturer_schedule/lecturer_schedule_cubit.dart';
import 'package:kai_schedule/bloc/navigation/navigation_cubit.dart';
import 'package:kai_schedule/bloc/navigation/navigation_state.dart';
import 'package:kai_schedule/bloc/student_schedule/student_schedule_cubit.dart';
import 'package:kai_schedule/bloc/student_score/student_score_bloc.dart';
import 'package:kai_schedule/bloc/student_score/student_score_events.dart';
import 'package:kai_schedule/local_data_provider/local_data_provider.dart';
import 'package:kai_schedule/presentation/kai_vk_news_screen.dart';
import 'package:kai_schedule/presentation/lecturer_schedule_screen.dart';
import 'package:kai_schedule/presentation/score_table_screen.dart';
import 'package:kai_schedule/presentation/student_schedule_screen.dart';
import 'package:kai_schedule/repository/repository.dart';
import 'package:kai_schedule/utility/styles.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(MyApp(scheduleRepository: ApiRepository(dataBase: LocalDataProvider())));
}

class MyApp extends StatelessWidget {
  final ApiRepository _scheduleRepository;
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
        theme: AppStyles.light,
        darkTheme: AppStyles.dark,
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
          selectedLabelStyle: AppStyles.selectedLabelStyle,
          onTap: (index) {
            context.read<NavigationCubit>().getNavBarItem(index);
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.schedule),
              label: 'Расписание',
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.school),
              label: 'Преподаватели',
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: 'БРС',
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.newspaper),
              label: 'Новости',
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            )
          ],
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
                    StudentScheduleCubit(context.read<ApiRepository>()),
                child: const StudentScheduleScreen()),
            BlocProvider(
                create: (context) =>
                    LecturerScheduleCubit(context.read<ApiRepository>()),
                child: const LecturerScheduleScreen()),
            BlocProvider(
                create: (context) =>
                    StudentScoreBloc(context.read<ApiRepository>())..add(AuthCheckEvent()),
                lazy: false,
                child: const ScoreTableScreen()),
            BlocProvider(
              create: (context) => KaiVkNewsBloc(context.read<ApiRepository>())
                ..add(PostFetched()),
              child: const NewsScreen(),
            ),
          ],
        );
      }),
    );
  }
}
