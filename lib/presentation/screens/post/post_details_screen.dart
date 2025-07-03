import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/post.dart';
import '../../../utils/toast_utils.dart';
import 'blocs/post_details/post_details_cubit.dart';

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final postDetailsCubit = context.read<PostDetailsCubit>();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(
                post.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 14.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
              child: Text(
                post.body,
                style: const TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postDetailsCubit.save(post);
          ToastUtils().show(context, 'Post Saved Successfully');
        },
        child: const Icon(
          Icons.bookmark,
          color: Colors.white,
        ),
      ),
    );
  }
}
