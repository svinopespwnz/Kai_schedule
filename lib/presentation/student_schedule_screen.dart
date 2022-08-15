import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/bloc/student_schedule_cubit.dart';
import 'package:kai_schedule/bloc/student_schedule_state.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/utility/styles.dart';

class StudentScheduleScreen extends StatefulWidget {
  const StudentScheduleScreen({Key? key}) : super(key: key);

  @override
  State<StudentScheduleScreen> createState() => _StudentScheduleScreenState();
}

class _StudentScheduleScreenState extends State<StudentScheduleScreen>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  String get _text => _textController.text;
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
    _textController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initialIndex = DateTime.now().weekday - 1;
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: initialIndex);
    context.read<StudentScheduleCubit>().checkIfGroupStored();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentScheduleCubit>();
    return BlocConsumer<StudentScheduleCubit, StudentScheduleState>(
      listener: (context, state) {
        if (state.status == ResponseStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ошибка получения данных, попробуйте позже')));
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              cubit.state.isButton
                  ? GestureDetector(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              cubit.state.group.isEmpty
                                  ? const Text('Группа: ?')
                                  : Text(cubit.state.group),
                              const SizedBox(width: 8),
                              const Icon(Icons.create,color: AppStyles.iconColor,)
                            ]),
                            Text(cubit.state.isWeekEven ? 'Четная' : 'Нечетная')
                          ]),
                      onTap: () {
                        cubit.toggleTextField(true);
                      },
                    )
                  : TextField(
                      keyboardType: TextInputType.phone,
                      autofocus: true,
                      controller: _textController,
                      decoration: const InputDecoration(
                          hintText: 'Введите № группы',
                          constraints: BoxConstraints(maxWidth: 150)),
                      onSubmitted: (value) async {
                        await cubit.getStudentScheduleByGroup(
                          _text,
                        );
                        cubit.toggleTextField(false);
                      },
                    ),
              FlutterSwitch(
                  activeTextColor: Colors.black87,
                  inactiveTextColor: Colors.black87,
                  inactiveColor: AppStyles.backgroundColor,
                  activeColor: AppStyles.backgroundColor,
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
        body: cubit.state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : BodyTabView(tabController: _tabController),
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
    final cubitState = context.read<StudentScheduleCubit>().state;
    final switchValue = cubitState.switchValue;
    final scheduleList = cubitState.data;
    final schedule = scheduleList.isNotEmpty
        ? (switchValue ? scheduleList[1] : scheduleList[0])
        : [];
    return scheduleList.isEmpty
        ? const Center(
            child: Text('Введите номер группы'),
          )
        : TabBarView(
            controller: _tabController,
            children: List.generate(
                6, (index) => StudentDayScheduleWidget(data: schedule[index])));
  }
}

class StudentDayScheduleWidget extends StatelessWidget {
  const StudentDayScheduleWidget({Key? key, required this.data})
      : super(key: key);
  final List<Lesson> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Center(
            child: Text('Нет занятий'),
          )
        : ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.dayTime.trim(),
                        style: AppStyles.dayTimeTextStyle,
                      ),
                      Text('Здание: ${data.buildNum}'.trim(),
                          style: AppStyles.buildingTextStyle),
                      Text('Ауд: ${data.audNum}'.trim(),
                          style: AppStyles.auditoriumTextStyle)
                    ]),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex:3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.disciplName,
                      style: AppStyles.disciplineNameTextStyle,
                    ),
                    Text(
                      data.disciplType,
                      style: AppStyles.disciplineTypeTextStyle,
                    ),
                    Text(
                      data.prepodName,
                      style: AppStyles.lecturerTextStyle,
                    ),
                    Text(
                      data.dayDate,
                      style: AppStyles.dayDateTextStyle,
                    )
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
