import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news/kai_vk_news_bloc.dart';
import 'package:kai_schedule/bloc/kai_vk_news/kai_vk_news_state.dart';
import 'package:kai_schedule/models/wall_post.dart' show Items;

import '../bloc/kai_vk_news/kai_vk_news_events.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<KaiVkNewsBloc>().add(PostFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KaiVkNewsBloc, KaiVkNewsState>(
        builder: (context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return const Center(child: Text('Ошибка получения данных'));
        case PostStatus.init:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case PostStatus.success:
          return Scaffold(
              appBar: AppBar(
                title: const Text('Новости'),
                centerTitle: true,
              ),
              body: state.data.isEmpty
                  ? const Center(
                      child: Text('Нет постов'),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final itemCount = state.data[index].attachments
                                ?.where((element) => element.type == 'photo')
                                .toList()
                                .length ??
                            1;

                        return index >= state.data.length
                            ? const BottomLoader()
                            : itemCount == 0 && state.data[index].text == ""
                                ? const SizedBox.shrink()
                                : PostListItem(
                                    post: state.data[index],
                                    itemCount: itemCount,
                                  );
                      }));

      }
    });
  }
}

class PostListItem extends StatefulWidget {
  final Items post;
  final int itemCount;

  const PostListItem({required this.post, required this.itemCount, Key? key})
      : super(key: key);

  @override
  State<PostListItem> createState() => _PostListItemState();
}

class _PostListItemState extends State<PostListItem> {
  int _currentImageIndex = 0;

  void _updateImageIndex(int index) {
    setState(() => _currentImageIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.post.attachments != null && widget.itemCount != 0)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView.builder(
                itemCount: widget.itemCount,
                scrollDirection: Axis.horizontal,
                onPageChanged: _updateImageIndex,
                itemBuilder: (context, photo) {
                  return Image.network(
                    widget.post.attachments?[photo].photo?.sizes
                            ?.firstWhere((element) =>
                                element.type == 'w' ||
                                element.type == 'z' ||
                                element.type == 'y' ||
                                element.type == 'x')
                            .url ??
                        'https://sun9-23.userapi.com/impg/DbfNg-1g0fvOKh9jJfvi-8BKOwIWhh23GlNwcg/dmTw6eFI24U.jpg?size=1620x2160&quality=96&sign=b43a755dd49bf2947ec74bcc9e91865e&type=album',
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  );
                },
              ),
            )
          else
            Image.network(
              'https://sun9-23.userapi.com/impg/DbfNg-1g0fvOKh9jJfvi-8BKOwIWhh23GlNwcg/dmTw6eFI24U.jpg?size=1620x2160&quality=96&sign=b43a755dd49bf2947ec74bcc9e91865e&type=album',
              fit: BoxFit.fitHeight,
            ),
          if (widget.post.attachments != null && widget.itemCount > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.post.attachments!
                  .where((element) => element.type == 'photo')
                  .map((photo) {
                int dotIndex = widget.post.attachments!.indexOf(photo);
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin:
                      const EdgeInsets.only(top: 8.0, right: 2.0, left: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == dotIndex
                        ? const Color.fromRGBO(0, 0, 0, 0.8)
                        : const Color.fromRGBO(0, 0, 0, 0.3),
                  ),
                );
              }).toList(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.post.text ?? ''),
          ),
        ],
      ),
    );
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
