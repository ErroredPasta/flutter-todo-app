// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['_id'] as String,
      todo: json['todo'] as String,
      done: json['done'] == null
          ? false
          : const BooleanToIntConverter()
              .fromJson((json['done'] as num).toInt()),
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'todo': instance.todo,
      'done': const BooleanToIntConverter().toJson(instance.done),
      'dateTime': instance.dateTime?.toIso8601String(),
    };
