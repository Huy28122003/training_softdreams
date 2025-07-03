import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/constants/strings.dart';

part 'post.g.dart';

@Entity(tableName: postsTableName)
@JsonSerializable(createToJson: false)
class Post extends Equatable {
  @PrimaryKey()
  final int id;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  List<Object?> get props => [id, title, body];
}
