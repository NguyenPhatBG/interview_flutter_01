import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_flutter/bloc/person_bloc.dart';

import 'bottom_loader.dart';
import 'person_list_item.dart';

class PersonList extends StatefulWidget {
  const PersonList({super.key});

  @override
  State<PersonList> createState() => _PostsListState();
}

class _PostsListState extends State<PersonList> {
  final _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonBloc, PersonState>(
      builder: (context, state) {
        switch (state.status) {
          case PersonStatus.failure:
            return const Center(child: Text('Failed to fetch persons'));
          case PersonStatus.success:
            if (state.persons.isEmpty) {
              return const Center(child: Text('No persons'));
            }
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.white,
              backgroundColor: Colors.blue,
              strokeWidth: 1,
              onRefresh: () async {
                context.read<PersonBloc>().add(PersonRefreshed());
                return Future<void>.delayed(const Duration(seconds: 3));
              },
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return index >= state.persons.length
                      ? const BottomLoader()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PersonListItem(person: state.persons[index]),
                            if (((index + 1) ==
                                    (3 * personLimit + startIndex)) &&
                                (state.persons[index].id ==
                                    state.persons.last.id))
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: const Text('No more data'),
                              )
                          ],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.persons.length
                    : state.persons.length + 1,
                controller: _scrollController,
              ),
            );
          case PersonStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PersonBloc>().add(PersonFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
