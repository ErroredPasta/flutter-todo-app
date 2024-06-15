import 'package:path/path.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data/datasource/todo_datasource.dart';
import 'package:todo_app/domain/repository/todo_repository.dart';

import '../../domain/domain_layer.dart';
import 'database/database_migration.dart';
import 'database/todo_table_info.dart';

part 'repository/todo_repository_impl.dart';
part 'datasource/database_todo_datasource.dart';
part 'database/database_helper.dart';

part 'data_layer.g.dart';