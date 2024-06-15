// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_layer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'7894c119ba11b11a4cc557d5b688ff0cb5839d94';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider =
    AutoDisposeFutureProvider<TodoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoRepositoryRef = AutoDisposeFutureProviderRef<TodoRepository>;
String _$todoDatasourceHash() => r'8b005aaf05bf65bd7c0546eef1733e1f5063d310';

/// See also [todoDatasource].
@ProviderFor(todoDatasource)
final todoDatasourceProvider =
    AutoDisposeFutureProvider<DatabaseTodoDatasource>.internal(
  todoDatasource,
  name: r'todoDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoDatasourceRef
    = AutoDisposeFutureProviderRef<DatabaseTodoDatasource>;
String _$databaseHash() => r'188c62e83fdd3de3cfa20ff1d604a441900c1017';

/// See also [database].
@ProviderFor(database)
final databaseProvider = AutoDisposeFutureProvider<Database>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DatabaseRef = AutoDisposeFutureProviderRef<Database>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
