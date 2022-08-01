import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kai_schedule/bloc/states.dart';
import 'package:kai_schedule/bloc/student_schedule_cubit.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/schedule_repository/schedule_repository.dart';

void main() async {
  runApp(MyApp(scheduleRepository: ScheduleRepository()));
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
        title: 'Flutter Demo',
        theme:
            ThemeData(primaryColor: Colors.black87, primarySwatch: Colors.grey),
        home: BlocProvider(
            create: (context) => StudentScheduleCubit(_scheduleRepository),
            child: const MyHomePage()),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _textContoller = TextEditingController();
  String get _text => _textContoller.text;
  late TabController _tabController;

  final tabs = const [
    Tab(text: 'Пн'),
    Tab(text: 'Вт'),
    Tab(text: 'Ср'),
    Tab(text: 'Чт'),
    Tab(text: 'Пт'),
    Tab(text: 'Сб'),
  ];
  @override
  void dispose() {
    _textContoller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initialIndex = DateTime.now().weekday;
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: initialIndex - 1);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentScheduleCubit>();
    return BlocBuilder<StudentScheduleCubit, StudentScheduleState>(
      builder: (context, state) => Scaffold(
        backgroundColor:
            const Color(0xFFEBEEF2), //Colors.white.withOpacity(0.9),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              cubit.state.isButton
                  ? GestureDetector(
                      child: Column(children: [
                        _text.isEmpty
                            ? const Text('Группа: ?')
                            : Text(cubit.state.group),
                        Text(cubit.state.isWeekEven ? 'Четная' : 'Нечетная')
                      ]),
                      onTap: () {
                        cubit.toggleTextField(true);
                      },
                    )
                  : TextField(

                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      controller: _textContoller,
                      decoration: const InputDecoration(
                          hintText: 'Введите № группы',
                          constraints: BoxConstraints(maxWidth: 150)),
                      onSubmitted: (value) {
                        cubit.getStudentScheduleByGroup(
                          _text,
                        );
                        cubit.toggleTextField(false);
                      },
                    ),
              FlutterSwitch(
                  activeTextColor: Colors.black87,
                  inactiveTextColor: Colors.black87,
                  inactiveColor: const Color(0xFFcacaca),
                  activeColor: const Color(0xFFcacaca),
                  activeText: "Четная",
                  inactiveText: "Нечетная",
                  valueFontSize: 14.0,
                  width: 120,
                  borderRadius: 25.0,
                  showOnOff: true,
                  value: cubit.state.switchValue,
                  onToggle: (value) {
                    cubit.toggleSwitch(value);
                  }),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.black87,
            tabs: tabs,
            controller: _tabController,
          ),
        ),
        body: BodyTabView(tabController: _tabController),
      ),
    );
  }
}

class BodyTabView extends StatelessWidget {
  const BodyTabView({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentScheduleCubit>();
    final switchValue = cubit.state.switchValue;
    final scheduleList = cubit.state.data;
    final schedule = scheduleList.isNotEmpty
        ? (switchValue ? scheduleList[1] : cubit.state.data[0])
        : [];
    return scheduleList.isEmpty
        ? const Center(
            child: Text('Введите номер группы'),
          )
        : TabBarView(
            controller: _tabController,
            children: [
              DayScheduleWidget(data: schedule[0]),
              DayScheduleWidget(data: schedule[1]),
              DayScheduleWidget(data: schedule[2]),
              DayScheduleWidget(data: schedule[3]),
              DayScheduleWidget(data: schedule[4]),
              DayScheduleWidget(data: schedule[5]),
            ],
          );
  }
}

class DayScheduleWidget extends StatelessWidget {
  const DayScheduleWidget({Key? key, required this.data}) : super(key: key);
  final List<Lesson> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Center(
            child: Text('Нет занятий'),
          )
        : ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return LectureCardWidget(
                data: data[index],
              );
            },
            itemCount: data.length,
          );
  }
}

class LectureCardWidget extends StatelessWidget {
  const LectureCardWidget({Key? key, required this.data}) : super(key: key);
  final Lesson data;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(data.dayTime.toString().trim()),
                          Text('Здание: ${data.buildNum}'),
                          Text('Ауд: ${data.audNum}')
                        ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      data.disciplName.trim(),
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ]),
          ),
        ));
  }
}
