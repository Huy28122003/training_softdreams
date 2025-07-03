import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/locator.dart';
import '../../../domain/usecases/post/get_list_posts.dart';
import '../../../domain/usecases/post/get_list_saved_posts.dart';
import '../../../domain/usecases/post/remove_saved_post.dart';
import 'blocs/post/post_bloc.dart';
import 'blocs/saved_posts/saved_posts_cubit.dart';
import 'saved_posts_screen.dart';
import 'widgets/post_list.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => SavedPostsCubit(
                      getListSavedPosts: locator<GetListSavedPosts>(),
                      removeSavedPost: locator<RemoveSavedPost>(),
                    )..getAllPosts(),
                    child: const SavedPostsScreen(),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => PostBloc(
          getListPosts: locator<GetListPosts>(),
        )..add(PostFetched()),
        child: const PostList(),
      ),
    );
  }
}
