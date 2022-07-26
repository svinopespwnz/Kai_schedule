import 'package:flutter/material.dart';
import 'package:kai_schedule/api/api_client.dart';
import 'package:kai_schedule/models/student_schedule.dart';
import 'package:kai_schedule/schedule_repository/schedule_repository.dart';

void main() async{
  runApp(const MyApp());
  final _api=ApiClient();
  print(await _api.getLecturersNamesList());
  final s=await _api.getLecturerSchedule("Медведев Михаил Викторович");
print(s.l2.first.disciplName);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final repo=ScheduleRepository();
  List<List<Lesson>>? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {

    data = await repo.getSchedule(group: "4301",isEven: false);
    final isEven= await repo.isEven();
    print(isEven);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4301'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                data?.first.first.dayTime.toString().trim() ??
                                    ''),
                            Text(
                                'Здание: ${data?.first.first.buildNum ?? ''}'),
                            Text('Ауд: ${data?.first.first.audNum ?? ''}')
                          ]),
                    ),
                    Expanded(
                        child: Text(
                      data?.first.first.disciplName.trim() ?? '',
                      textDirection: TextDirection.ltr,
                    )),
                  ]));
        },
        itemCount: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
