// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['_id'] as String,
      title: json['title'] as String,
      done: json['done'] == null
          ? false
          : const BooleanToIntConverter()
              .fromJson((json['done'] as num).toInt()),
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      note: json['note'] as String? ?? null,
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'done': const BooleanToIntConverter().toJson(instance.done),
      'dateTime': instance.dateTime?.toIso8601String(),
      'note': instance.note,
    };
