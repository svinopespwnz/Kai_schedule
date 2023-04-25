import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/response_status_enum.dart';
import 'package:kai_schedule/bloc/student_score/student_score_bloc.dart';
import 'package:kai_schedule/bloc/student_score/student_score_events.dart';
import 'package:kai_schedule/bloc/student_score/student_score_state.dart';
import 'package:kai_schedule/utility/styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../bloc/auth_status_enum.dart';

class ScoreTableScreen extends StatelessWidget {
  const ScoreTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentScoreBloc, StudentScoreState>(
        listener: (context, state) {
      if (state.responseStatus == ResponseStatus.failure &&
          (state.authStatus == AuthStatus.unauthorized ||
              state.authStatus == AuthStatus.unknown)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ошибка авторизации')),
          );
      }
      if (state.responseStatus == ResponseStatus.failure &&
          state.authStatus == AuthStatus.authorized) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Ошибка получения данных')),
          );
      }
    }, builder: (context, state) {
      switch (state.authStatus) {
        case AuthStatus.authorized:
          return const ScoreTable();
        case AuthStatus.unauthorized:
          return const LoginForm();
        case AuthStatus.unknown:
          return const CircularProgressScore();
      }
    });
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController loginTextController;
  late final TextEditingController passTextController;
  bool isAuthInProgress = false;
  @override
  void initState() {
    super.initState();
    loginTextController = TextEditingController();
    passTextController = TextEditingController();
  }

  @override
  void dispose() {
    loginTextController.dispose();
    passTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentScoreBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('БРС')),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 30.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Логин'),
                  controller: loginTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите логин';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Пароль'),
                  controller: passTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите пароль';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                isAuthInProgress
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            bloc.add(AuthEvent(
                                login: loginTextController.text,
                                pass: passTextController.text));
                            setState(() {
                              isAuthInProgress = true;
                            });
                          }
                        },
                        child: const Text('Войти'),
                      ),
                const SizedBox(
                  height: 12,
                ),
              ],
            )),
      ),
    );
  }
}

class ScoreTable extends StatefulWidget {
  const ScoreTable({Key? key}) : super(key: key);

  @override
  State<ScoreTable> createState() => _ScoreTableState();
}

class _ScoreTableState extends State<ScoreTable>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    context.read<StudentScoreBloc>().add(GetSemesterScoreEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentScoreBloc, StudentScoreState>(
        builder: (context, state) {
      return (state.scoreData.isEmpty)
          ? const CircularProgressScore()
          : const ScoreBodyTabView();
    });
  }
}

class CircularProgressScore extends StatelessWidget {
  const CircularProgressScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('БРС')),
        ),
        body: const Center(child: CircularProgressIndicator()));
  }
}

class ScoreBodyTabView extends StatefulWidget {
  const ScoreBodyTabView({Key? key}) : super(key: key);

  @override
  State<ScoreBodyTabView> createState() => _ScoreBodyTabViewState();
}

class _ScoreBodyTabViewState extends State<ScoreBodyTabView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final List<Tab> tabs;
  void changeSemester(int index) {
    context
        .read<StudentScoreBloc>()
        .add(GetSemesterScoreEvent(semester: index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final bloc = context.read<StudentScoreBloc>();
    tabs = List.generate(
        bloc.state.semesters,
        (index) => Tab(
              text: (index + 1).toString(),
            ));
    _tabController = TabController(
        length: tabs.length, vsync: this, initialIndex: tabs.length - 1);
    _tabController.addListener(() {
      changeSemester(_tabController.index + 1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.read<StudentScoreBloc>().add(LogOutEvent());
                },
                icon: const Icon(Icons.exit_to_app))
          ],
          title: const Text('БРС'),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController,
            tabs: tabs,
          )),
      body: TabBarView(
          controller: _tabController,
          children: List.generate(
              tabs.length, (index) => const SemesterScoreTable())),
    );
  }
}

class SemesterScoreTable extends StatefulWidget {
  const SemesterScoreTable({Key? key}) : super(key: key);

  @override
  State<SemesterScoreTable> createState() => _SemesterScoreTableState();
}

class _SemesterScoreTableState extends State<SemesterScoreTable> {
  _showModalBottomSheet(BuildContext context, List<String> data) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (context) {
          return _BottomSheetContent(
            data: data,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentScoreBloc, StudentScoreState>(
        builder: (context, state) {
      return state.isScoreUpdating
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: state.scoreData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _showModalBottomSheet(context, state.scoreData[index]);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(child: Text(state.scoreData[index][1])),
                          CircularPercentIndicator(
                            percent:
                                double.parse(state.scoreData[index][12]) / 100,
                            radius: 25,
                            animation: true,
                            center: Text(state.scoreData[index][12]),
                            circularStrokeCap: CircularStrokeCap.round,
                            progressColor: Colors.lightGreen,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
    });
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({Key? key, required this.data}) : super(key: key);
  final List<String> data;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  data[1],
                  style: AppStyles.modalBottomSheetDisciplineNameTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '1 аттестация',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text('${data[2]}/${data[3]}',
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '2 аттестация',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text('${data[4]}/${data[5]}',
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '3 аттестация',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text('${data[6]}/${data[7]}',
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '4 аттестация',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text('${data[8]}/${data[9]}',
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '5 аттестация',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text('${data[10]}/${data[11]}',
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Предварительная оценка',
                      style: AppStyles.modalBottomSheetScoreTextStyle,
                    ),
                    Text(data[12],
                        style: AppStyles.modalBottomSheetScoreTextStyle)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
