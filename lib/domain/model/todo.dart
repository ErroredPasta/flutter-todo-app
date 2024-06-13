// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
sealed class Todo with _$Todo {
  const factory Todo({
    @JsonKey(name: '_id') required String id,
    required String title,
    @BooleanToIntConverter() @Default(false) bool done,
    DateTime? dateTime,
    @Default(null) String? note,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

class BooleanToIntConverter implements JsonConverter<bool, int> {
  const BooleanToIntConverter();

  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) {
    return object ? 1 : 0;
  }
}
