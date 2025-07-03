import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'blocs/saved_posts/saved_posts_cubit.dart';
import 'widgets/widgets.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
      ),
      body: BlocBuilder<SavedPostsCubit, SavedPostsState>(
        builder: (context, state) {
          if (state.status.isSuccess) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, index) {
                final post = posts[index];
                return PostListItem(
                  post: post,
                  isRemovable: true,
                  onRemove: context.read<SavedPostsCubit>().removePost,
                );
              },
            );
          }

          if (state.status.isFailure) {
            return const Center(
              child: Text('error'),
            );
          }

          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
    );
  }
}
