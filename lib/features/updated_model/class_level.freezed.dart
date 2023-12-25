// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_level.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClassLevel _$ClassLevelFromJson(Map<String, dynamic> json) {
  return _ClassLevel.fromJson(json);
}

/// @nodoc
mixin _$ClassLevel {
  int get id => throw _privateConstructorUsedError;
  String get class_name => throw _privateConstructorUsedError;
  bool get is_bachelors_class => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassLevelCopyWith<ClassLevel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassLevelCopyWith<$Res> {
  factory $ClassLevelCopyWith(
          ClassLevel value, $Res Function(ClassLevel) then) =
      _$ClassLevelCopyWithImpl<$Res, ClassLevel>;
  @useResult
  $Res call({int id, String class_name, bool is_bachelors_class});
}

/// @nodoc
class _$ClassLevelCopyWithImpl<$Res, $Val extends ClassLevel>
    implements $ClassLevelCopyWith<$Res> {
  _$ClassLevelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? class_name = null,
    Object? is_bachelors_class = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as String,
      is_bachelors_class: null == is_bachelors_class
          ? _value.is_bachelors_class
          : is_bachelors_class // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassLevelImplCopyWith<$Res>
    implements $ClassLevelCopyWith<$Res> {
  factory _$$ClassLevelImplCopyWith(
          _$ClassLevelImpl value, $Res Function(_$ClassLevelImpl) then) =
      __$$ClassLevelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String class_name, bool is_bachelors_class});
}

/// @nodoc
class __$$ClassLevelImplCopyWithImpl<$Res>
    extends _$ClassLevelCopyWithImpl<$Res, _$ClassLevelImpl>
    implements _$$ClassLevelImplCopyWith<$Res> {
  __$$ClassLevelImplCopyWithImpl(
      _$ClassLevelImpl _value, $Res Function(_$ClassLevelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? class_name = null,
    Object? is_bachelors_class = null,
  }) {
    return _then(_$ClassLevelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      class_name: null == class_name
          ? _value.class_name
          : class_name // ignore: cast_nullable_to_non_nullable
              as String,
      is_bachelors_class: null == is_bachelors_class
          ? _value.is_bachelors_class
          : is_bachelors_class // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ClassLevelImpl implements _ClassLevel {
  const _$ClassLevelImpl(
      {required this.id,
      required this.class_name,
      required this.is_bachelors_class});

  factory _$ClassLevelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassLevelImplFromJson(json);

  @override
  final int id;
  @override
  final String class_name;
  @override
  final bool is_bachelors_class;

  @override
  String toString() {
    return 'ClassLevel(id: $id, class_name: $class_name, is_bachelors_class: $is_bachelors_class)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassLevelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.class_name, class_name) ||
                other.class_name == class_name) &&
            (identical(other.is_bachelors_class, is_bachelors_class) ||
                other.is_bachelors_class == is_bachelors_class));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, class_name, is_bachelors_class);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassLevelImplCopyWith<_$ClassLevelImpl> get copyWith =>
      __$$ClassLevelImplCopyWithImpl<_$ClassLevelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassLevelImplToJson(
      this,
    );
  }
}

abstract class _ClassLevel implements ClassLevel {
  const factory _ClassLevel(
      {required final int id,
      required final String class_name,
      required final bool is_bachelors_class}) = _$ClassLevelImpl;

  factory _ClassLevel.fromJson(Map<String, dynamic> json) =
      _$ClassLevelImpl.fromJson;

  @override
  int get id;
  @override
  String get class_name;
  @override
  bool get is_bachelors_class;
  @override
  @JsonKey(ignore: true)
  _$$ClassLevelImplCopyWith<_$ClassLevelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
