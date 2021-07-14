// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'env.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EnvironmentTearOff {
  const _$EnvironmentTearOff();

  Prod prod() {
    return const Prod();
  }

  Staging staging() {
    return const Staging();
  }

  Dev dev() {
    return const Dev();
  }
}

/// @nodoc
const $Environment = _$EnvironmentTearOff();

/// @nodoc
mixin _$Environment {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prod,
    required TResult Function() staging,
    required TResult Function() dev,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prod,
    TResult Function()? staging,
    TResult Function()? dev,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Prod value) prod,
    required TResult Function(Staging value) staging,
    required TResult Function(Dev value) dev,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Prod value)? prod,
    TResult Function(Staging value)? staging,
    TResult Function(Dev value)? dev,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvironmentCopyWith<$Res> {
  factory $EnvironmentCopyWith(
          Environment value, $Res Function(Environment) then) =
      _$EnvironmentCopyWithImpl<$Res>;
}

/// @nodoc
class _$EnvironmentCopyWithImpl<$Res> implements $EnvironmentCopyWith<$Res> {
  _$EnvironmentCopyWithImpl(this._value, this._then);

  final Environment _value;
  // ignore: unused_field
  final $Res Function(Environment) _then;
}

/// @nodoc
abstract class $ProdCopyWith<$Res> {
  factory $ProdCopyWith(Prod value, $Res Function(Prod) then) =
      _$ProdCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProdCopyWithImpl<$Res> extends _$EnvironmentCopyWithImpl<$Res>
    implements $ProdCopyWith<$Res> {
  _$ProdCopyWithImpl(Prod _value, $Res Function(Prod) _then)
      : super(_value, (v) => _then(v as Prod));

  @override
  Prod get _value => super._value as Prod;
}

/// @nodoc

class _$Prod implements Prod {
  const _$Prod();

  @override
  String toString() {
    return 'Environment.prod()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Prod);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prod,
    required TResult Function() staging,
    required TResult Function() dev,
  }) {
    return prod();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prod,
    TResult Function()? staging,
    TResult Function()? dev,
    required TResult orElse(),
  }) {
    if (prod != null) {
      return prod();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Prod value) prod,
    required TResult Function(Staging value) staging,
    required TResult Function(Dev value) dev,
  }) {
    return prod(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Prod value)? prod,
    TResult Function(Staging value)? staging,
    TResult Function(Dev value)? dev,
    required TResult orElse(),
  }) {
    if (prod != null) {
      return prod(this);
    }
    return orElse();
  }
}

abstract class Prod implements Environment {
  const factory Prod() = _$Prod;
}

/// @nodoc
abstract class $StagingCopyWith<$Res> {
  factory $StagingCopyWith(Staging value, $Res Function(Staging) then) =
      _$StagingCopyWithImpl<$Res>;
}

/// @nodoc
class _$StagingCopyWithImpl<$Res> extends _$EnvironmentCopyWithImpl<$Res>
    implements $StagingCopyWith<$Res> {
  _$StagingCopyWithImpl(Staging _value, $Res Function(Staging) _then)
      : super(_value, (v) => _then(v as Staging));

  @override
  Staging get _value => super._value as Staging;
}

/// @nodoc

class _$Staging implements Staging {
  const _$Staging();

  @override
  String toString() {
    return 'Environment.staging()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Staging);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prod,
    required TResult Function() staging,
    required TResult Function() dev,
  }) {
    return staging();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prod,
    TResult Function()? staging,
    TResult Function()? dev,
    required TResult orElse(),
  }) {
    if (staging != null) {
      return staging();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Prod value) prod,
    required TResult Function(Staging value) staging,
    required TResult Function(Dev value) dev,
  }) {
    return staging(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Prod value)? prod,
    TResult Function(Staging value)? staging,
    TResult Function(Dev value)? dev,
    required TResult orElse(),
  }) {
    if (staging != null) {
      return staging(this);
    }
    return orElse();
  }
}

abstract class Staging implements Environment {
  const factory Staging() = _$Staging;
}

/// @nodoc
abstract class $DevCopyWith<$Res> {
  factory $DevCopyWith(Dev value, $Res Function(Dev) then) =
      _$DevCopyWithImpl<$Res>;
}

/// @nodoc
class _$DevCopyWithImpl<$Res> extends _$EnvironmentCopyWithImpl<$Res>
    implements $DevCopyWith<$Res> {
  _$DevCopyWithImpl(Dev _value, $Res Function(Dev) _then)
      : super(_value, (v) => _then(v as Dev));

  @override
  Dev get _value => super._value as Dev;
}

/// @nodoc

class _$Dev implements Dev {
  const _$Dev();

  @override
  String toString() {
    return 'Environment.dev()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Dev);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prod,
    required TResult Function() staging,
    required TResult Function() dev,
  }) {
    return dev();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prod,
    TResult Function()? staging,
    TResult Function()? dev,
    required TResult orElse(),
  }) {
    if (dev != null) {
      return dev();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Prod value) prod,
    required TResult Function(Staging value) staging,
    required TResult Function(Dev value) dev,
  }) {
    return dev(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Prod value)? prod,
    TResult Function(Staging value)? staging,
    TResult Function(Dev value)? dev,
    required TResult orElse(),
  }) {
    if (dev != null) {
      return dev(this);
    }
    return orElse();
  }
}

abstract class Dev implements Environment {
  const factory Dev() = _$Dev;
}
