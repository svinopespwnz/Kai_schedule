import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news_cubit.dart';
import 'package:kai_schedule/bloc/kai_vk_news_state.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<KaiVkNewsCubit>().getWall();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KaiVkNewsCubit, KaiVkNewsState>(
      builder: (context, state) => Scaffold(
        body: state.data.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text(state.data[index].text ?? ''),
                  );
                }),
      ),
    );
  }
}
