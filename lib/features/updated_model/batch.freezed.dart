// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'batch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Batch _$BatchFromJson(Map<String, dynamic> json) {
  return _Batch.fromJson(json);
}

/// @nodoc
mixin _$Batch {
  int get id => throw _privateConstructorUsedError;
  String get batch_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BatchCopyWith<Batch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BatchCopyWith<$Res> {
  factory $BatchCopyWith(Batch value, $Res Function(Batch) then) =
      _$BatchCopyWithImpl<$Res, Batch>;
  @useResult
  $Res call({int id, String batch_name});
}

/// @nodoc
class _$BatchCopyWithImpl<$Res, $Val extends Batch>
    implements $BatchCopyWith<$Res> {
  _$BatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? batch_name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      batch_name: null == batch_name
          ? _value.batch_name
          : batch_name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BatchImplCopyWith<$Res> implements $BatchCopyWith<$Res> {
  factory _$$BatchImplCopyWith(
          _$BatchImpl value, $Res Function(_$BatchImpl) then) =
      __$$BatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String batch_name});
}

/// @nodoc
class __$$BatchImplCopyWithImpl<$Res>
    extends _$BatchCopyWithImpl<$Res, _$BatchImpl>
    implements _$$BatchImplCopyWith<$Res> {
  __$$BatchImplCopyWithImpl(
      _$BatchImpl _value, $Res Function(_$BatchImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? batch_name = null,
  }) {
    return _then(_$BatchImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      batch_name: null == batch_name
          ? _value.batch_name
          : batch_name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BatchImpl implements _Batch {
  const _$BatchImpl({required this.id, required this.batch_name});

  factory _$BatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$BatchImplFromJson(json);

  @override
  final int id;
  @override
  final String batch_name;

  @override
  String toString() {
    return 'Batch(id: $id, batch_name: $batch_name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BatchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.batch_name, batch_name) ||
                other.batch_name == batch_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, batch_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BatchImplCopyWith<_$BatchImpl> get copyWith =>
      __$$BatchImplCopyWithImpl<_$BatchImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BatchImplToJson(
      this,
    );
  }
}

abstract class _Batch implements Batch {
  const factory _Batch(
      {required final int id, required final String batch_name}) = _$BatchImpl;

  factory _Batch.fromJson(Map<String, dynamic> json) = _$BatchImpl.fromJson;

  @override
  int get id;
  @override
  String get batch_name;
  @override
  @JsonKey(ignore: true)
  _$$BatchImplCopyWith<_$BatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
