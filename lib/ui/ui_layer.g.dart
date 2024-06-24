// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui_layer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoListControllerHash() =>
    r'bb6dbec0cde23f4528035d97afe6658851d4b7eb';

/// See also [TodoListController].
@ProviderFor(TodoListController)
final todoListControllerProvider =
    AutoDisposeAsyncNotifierProvider<TodoListController, List<Todo>>.internal(
  TodoListController.new,
  name: r'todoListControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoListControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoListController = AutoDisposeAsyncNotifier<List<Todo>>;
String _$todoDetailControllerHash() =>
    r'af89b3b454e15aa134004ccbe03910559981b3ca';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TodoDetailController
    extends BuildlessAutoDisposeAsyncNotifier<Todo> {
  late final String todoId;

  FutureOr<Todo> build(
    String todoId,
  );
}

/// See also [TodoDetailController].
@ProviderFor(TodoDetailController)
const todoDetailControllerProvider = TodoDetailControllerFamily();

/// See also [TodoDetailController].
class TodoDetailControllerFamily extends Family<AsyncValue<Todo>> {
  /// See also [TodoDetailController].
  const TodoDetailControllerFamily();

  /// See also [TodoDetailController].
  TodoDetailControllerProvider call(
    String todoId,
  ) {
    return TodoDetailControllerProvider(
      todoId,
    );
  }

  @override
  TodoDetailControllerProvider getProviderOverride(
    covariant TodoDetailControllerProvider provider,
  ) {
    return call(
      provider.todoId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoDetailControllerProvider';
}

/// See also [TodoDetailController].
class TodoDetailControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TodoDetailController, Todo> {
  /// See also [TodoDetailController].
  TodoDetailControllerProvider(
    String todoId,
  ) : this._internal(
          () => TodoDetailController()..todoId = todoId,
          from: todoDetailControllerProvider,
          name: r'todoDetailControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoDetailControllerHash,
          dependencies: TodoDetailControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoDetailControllerFamily._allTransitiveDependencies,
          todoId: todoId,
        );

  TodoDetailControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todoId,
  }) : super.internal();

  final String todoId;

  @override
  FutureOr<Todo> runNotifierBuild(
    covariant TodoDetailController notifier,
  ) {
    return notifier.build(
      todoId,
    );
  }

  @override
  Override overrideWith(TodoDetailController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoDetailControllerProvider._internal(
        () => create()..todoId = todoId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todoId: todoId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TodoDetailController, Todo>
      createElement() {
    return _TodoDetailControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoDetailControllerProvider && other.todoId == todoId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todoId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoDetailControllerRef on AutoDisposeAsyncNotifierProviderRef<Todo> {
  /// The parameter `todoId` of this provider.
  String get todoId;
}

class _TodoDetailControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TodoDetailController, Todo>
    with TodoDetailControllerRef {
  _TodoDetailControllerProviderElement(super.provider);

  @override
  String get todoId => (origin as TodoDetailControllerProvider).todoId;
}

String _$todoEditControllerHash() =>
    r'89c765fe0627aff1b08004a185dd1e35cc3b13e2';

abstract class _$TodoEditController extends BuildlessAutoDisposeNotifier<Todo> {
  late final Todo todo;

  Todo build(
    Todo todo,
  );
}

/// See also [TodoEditController].
@ProviderFor(TodoEditController)
const todoEditControllerProvider = TodoEditControllerFamily();

/// See also [TodoEditController].
class TodoEditControllerFamily extends Family<Todo> {
  /// See also [TodoEditController].
  const TodoEditControllerFamily();

  /// See also [TodoEditController].
  TodoEditControllerProvider call(
    Todo todo,
  ) {
    return TodoEditControllerProvider(
      todo,
    );
  }

  @override
  TodoEditControllerProvider getProviderOverride(
    covariant TodoEditControllerProvider provider,
  ) {
    return call(
      provider.todo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'todoEditControllerProvider';
}

/// See also [TodoEditController].
class TodoEditControllerProvider
    extends AutoDisposeNotifierProviderImpl<TodoEditController, Todo> {
  /// See also [TodoEditController].
  TodoEditControllerProvider(
    Todo todo,
  ) : this._internal(
          () => TodoEditController()..todo = todo,
          from: todoEditControllerProvider,
          name: r'todoEditControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$todoEditControllerHash,
          dependencies: TodoEditControllerFamily._dependencies,
          allTransitiveDependencies:
              TodoEditControllerFamily._allTransitiveDependencies,
          todo: todo,
        );

  TodoEditControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.todo,
  }) : super.internal();

  final Todo todo;

  @override
  Todo runNotifierBuild(
    covariant TodoEditController notifier,
  ) {
    return notifier.build(
      todo,
    );
  }

  @override
  Override overrideWith(TodoEditController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TodoEditControllerProvider._internal(
        () => create()..todo = todo,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        todo: todo,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TodoEditController, Todo> createElement() {
    return _TodoEditControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoEditControllerProvider && other.todo == todo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, todo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoEditControllerRef on AutoDisposeNotifierProviderRef<Todo> {
  /// The parameter `todo` of this provider.
  Todo get todo;
}

class _TodoEditControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TodoEditController, Todo>
    with TodoEditControllerRef {
  _TodoEditControllerProviderElement(super.provider);

  @override
  Todo get todo => (origin as TodoEditControllerProvider).todo;
}

String _$todoAddControllerHash() => r'd5e6baa48b0d52ddd97752d6f3aeb87bcdc086a5';

/// See also [TodoAddController].
@ProviderFor(TodoAddController)
final todoAddControllerProvider =
    AutoDisposeNotifierProvider<TodoAddController, Todo>.internal(
  TodoAddController.new,
  name: r'todoAddControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoAddControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoAddController = AutoDisposeNotifier<Todo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
