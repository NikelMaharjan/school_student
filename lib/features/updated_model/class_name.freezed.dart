// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClassName _$ClassNameFromJson(Map<String, dynamic> json) {
  return _ClassName.fromJson(json);
}

/// @nodoc
mixin _$ClassName {
  int get id => throw _privateConstructorUsedError;
  Batch get batch => throw _privateConstructorUsedError;
  ClassLevel get class_level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassNameCopyWith<ClassName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassNameCopyWith<$Res> {
  factory $ClassNameCopyWith(ClassName value, $Res Function(ClassName) then) =
      _$ClassNameCopyWithImpl<$Res, ClassName>;
  @useResult
  $Res call({int id, Batch batch, ClassLevel class_level});

  $BatchCopyWith<$Res> get batch;
  $ClassLevelCopyWith<$Res> get class_level;
}

/// @nodoc
class _$ClassNameCopyWithImpl<$Res, $Val extends ClassName>
    implements $ClassNameCopyWith<$Res> {
  _$ClassNameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? batch = null,
    Object? class_level = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      batch: null == batch
          ? _value.batch
          : batch // ignore: cast_nullable_to_non_nullable
              as Batch,
      class_level: null == class_level
          ? _value.class_level
          : class_level // ignore: cast_nullable_to_non_nullable
              as ClassLevel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BatchCopyWith<$Res> get batch {
    return $BatchCopyWith<$Res>(_value.batch, (value) {
      return _then(_value.copyWith(batch: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClassLevelCopyWith<$Res> get class_level {
    return $ClassLevelCopyWith<$Res>(_value.class_level, (value) {
      return _then(_value.copyWith(class_level: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClassNameImplCopyWith<$Res>
    implements $ClassNameCopyWith<$Res> {
  factory _$$ClassNameImplCopyWith(
          _$ClassNameImpl value, $Res Function(_$ClassNameImpl) then) =
      __$$ClassNameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, Batch batch, ClassLevel class_level});

  @override
  $BatchCopyWith<$Res> get batch;
  @override
  $ClassLevelCopyWith<$Res> get class_level;
}

/// @nodoc
class __$$ClassNameImplCopyWithImpl<$Res>
    extends _$ClassNameCopyWithImpl<$Res, _$ClassNameImpl>
    implements _$$ClassNameImplCopyWith<$Res> {
  __$$ClassNameImplCopyWithImpl(
      _$ClassNameImpl _value, $Res Function(_$ClassNameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? batch = null,
    Object? class_level = null,
  }) {
    return _then(_$ClassNameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      batch: null == batch
          ? _value.batch
          : batch // ignore: cast_nullable_to_non_nullable
              as Batch,
      class_level: null == class_level
          ? _value.class_level
          : class_level // ignore: cast_nullable_to_non_nullable
              as ClassLevel,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ClassNameImpl implements _ClassName {
  const _$ClassNameImpl(
      {required this.id, required this.batch, required this.class_level});

  factory _$ClassNameImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassNameImplFromJson(json);

  @override
  final int id;
  @override
  final Batch batch;
  @override
  final ClassLevel class_level;

  @override
  String toString() {
    return 'ClassName(id: $id, batch: $batch, class_level: $class_level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassNameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.batch, batch) || other.batch == batch) &&
            (identical(other.class_level, class_level) ||
                other.class_level == class_level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, batch, class_level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassNameImplCopyWith<_$ClassNameImpl> get copyWith =>
      __$$ClassNameImplCopyWithImpl<_$ClassNameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassNameImplToJson(
      this,
    );
  }
}

abstract class _ClassName implements ClassName {
  const factory _ClassName(
      {required final int id,
      required final Batch batch,
      required final ClassLevel class_level}) = _$ClassNameImpl;

  factory _ClassName.fromJson(Map<String, dynamic> json) =
      _$ClassNameImpl.fromJson;

  @override
  int get id;
  @override
  Batch get batch;
  @override
  ClassLevel get class_level;
  @override
  @JsonKey(ignore: true)
  _$$ClassNameImplCopyWith<_$ClassNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
