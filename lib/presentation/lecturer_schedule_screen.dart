import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/lecturer_schedule_cubit.dart';
import 'package:kai_schedule/bloc/lecturer_schedule_state.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/models/lecturer_schedule.dart';
import 'package:kai_schedule/utility/styles.dart';

class LecturerScheduleScreen extends StatefulWidget {
  const LecturerScheduleScreen({Key? key}) : super(key: key);

  @override
  State<LecturerScheduleScreen> createState() => _LecturerScheduleScreenState();
}

class _LecturerScheduleScreenState extends State<LecturerScheduleScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
    final cubit = context.read<LecturerScheduleCubit>();
    return BlocConsumer<LecturerScheduleCubit, LecturerScheduleState>(
      listener: (context, state) {
        if (state.status == ResponseStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  'Ошибка получения данных, попробуйте позже или проверьте интернет')));
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
    return (cubitState.name.isEmpty ||
            cubitState.status == ResponseStatus.failure)
        ? const Center(
            child: Text('Введите имя преподавателя'),
          )
        : TabBarView(
            controller: _tabController,
            children: List.generate(6,
                (index) => LecturerDayScheduleWidget(data: schedule[index])));
  }
}

class LecturerDayScheduleWidget extends StatelessWidget {
  const LecturerDayScheduleWidget({Key? key, required this.data})
      : super(key: key);
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
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.disciplName.trim(),
                      style: AppStyles.disciplineNameTextStyle,
                    ),
                    Text(
                      data.disciplType.trim(),
                      style: AppStyles.disciplineTypeTextStyle,
                    ),
                    Text(
                      data.group.trim(),
                      style: AppStyles.groupNumberTextStyle,
                    ),
                    Text(
                      data.dayDate.trim(),
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
