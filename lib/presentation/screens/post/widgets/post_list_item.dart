import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di/locator.dart';
import '../../../../domain/models/post.dart';
import '../../../../domain/usecases/post/save_post.dart';
import '../blocs/post_details/post_details_cubit.dart';
import '../post_details_screen.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key? key,
    required this.post,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  final Post post;
  final bool isRemovable;
  final void Function(Post post)? onRemove;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => PostDetailsCubit(
                  savePost: locator<SavePost>(),
                ),
                child: PostDetailsScreen(post: post),
              ),
            ),
          );
        },
        leading: Text('${post.id}', style: textTheme.bodySmall),
        title: Text(post.title),
        isThreeLine: true,
        subtitle: Text(post.body),
        dense: true,
        trailing: isRemovable
            ? IconButton(
                onPressed: () => onRemove!(post),
                icon: const Icon(Icons.delete),
              )
            : null,
      ),
    );
  }
}
