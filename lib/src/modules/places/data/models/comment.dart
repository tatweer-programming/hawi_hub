import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int id;
  final String text;
  final int userId;

  const Comment({
    required this.userId,
    required this.id,
    required this.text,
  });
  @override
  List<Object?> get props => [id, text];
}
