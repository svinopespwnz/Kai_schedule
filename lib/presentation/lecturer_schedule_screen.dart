import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/lecturer_schedule_cubit.dart';
import 'package:kai_schedule/bloc/lecturer_schedule_state.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/models/lecturer_schedule.dart';

class LecturerScheduleScreen extends StatefulWidget {
  const LecturerScheduleScreen({Key? key}) : super(key: key);

  @override
  State<LecturerScheduleScreen> createState() => _LecturerScheduleScreenState();
}

class _LecturerScheduleScreenState extends State<LecturerScheduleScreen>
    with SingleTickerProviderStateMixin {
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final initialIndex = DateTime.now().weekday - 1;
    _tabController =
        TabController(length: 6, vsync: this, initialIndex: initialIndex);
    context.read<LecturerScheduleCubit>().fillLecturersList();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LecturerScheduleCubit>();
    return BlocConsumer<LecturerScheduleCubit, LecturerScheduleState>(
      listener: (context, state) {
        if (state.status == ResponseStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Ошибка получения данных, попробуйте позже')));
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: const Color(0xFFEBEEF2),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Преподаватель: '),
                Text(cubit.state.isWeekEven ? 'Четная' : 'Нечетная')
              ]),
              Expanded(
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return cubit.state.listOfLecturers.where((String option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await cubit.getLecturersSchedule(selection);
                  },
                ),
              )
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
            : (BodyTabView(tabController: _tabController)),
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
    final cubitState = context.read<LecturerScheduleCubit>().state;
    final schedule = cubitState.data;
    return cubitState.name.isEmpty
        ? const Center(
            child: Text('Введите имя преподавателя'),
          )
        : (cubitState.status == ResponseStatus.success
            ? TabBarView(
                controller: _tabController,
                children: [
                  DayScheduleWidget(data: schedule[0]),
                  DayScheduleWidget(data: schedule[1]),
                  DayScheduleWidget(data: schedule[2]),
                  DayScheduleWidget(data: schedule[3]),
                  DayScheduleWidget(data: schedule[4]),
                  DayScheduleWidget(data: schedule[5]),
                ],
              )
            : const Center(
                child: Text('Нет занятий'),
              ));
  }
}

class DayScheduleWidget extends StatelessWidget {
  const DayScheduleWidget({Key? key, required this.data}) : super(key: key);
  final List<LecturerLesson>? data;

  @override
  Widget build(BuildContext context) {
    return data == null
        ? const Center(
            child: Text('Нет занятий'),
          )
        : ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (BuildContext context, int index) {
              return LectureCardWidget(
                data: data![index],
              );
            },
            itemCount: data!.length,
          );
  }
}

class LectureCardWidget extends StatelessWidget {
  const LectureCardWidget({Key? key, required this.data}) : super(key: key);
  final LecturerLesson data;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(data.dayTime),
                      Text('Здание: ${data.buildNum}'),
                      Text('Ауд: ${data.audNum}')
                    ]),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  data.disciplName,
                ),
              ),
            ]),
          ),
        ));
  }
}