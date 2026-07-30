// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Plan {

 int get id; String get nombre;@JsonKey(name: 'precio_mensual') double get precioMensual;@JsonKey(name: 'precio_anual') double get precioAnual;@JsonKey(name: 'stripe_price_id') String? get stripePriceId; bool get activo;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.precioMensual, precioMensual) || other.precioMensual == precioMensual)&&(identical(other.precioAnual, precioAnual) || other.precioAnual == precioAnual)&&(identical(other.stripePriceId, stripePriceId) || other.stripePriceId == stripePriceId)&&(identical(other.activo, activo) || other.activo == activo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombre,precioMensual,precioAnual,stripePriceId,activo);

@override
String toString() {
  return 'Plan(id: $id, nombre: $nombre, precioMensual: $precioMensual, precioAnual: $precioAnual, stripePriceId: $stripePriceId, activo: $activo)';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 int id, String nombre,@JsonKey(name: 'precio_mensual') double precioMensual,@JsonKey(name: 'precio_anual') double precioAnual,@JsonKey(name: 'stripe_price_id') String? stripePriceId, bool activo
});




}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nombre = null,Object? precioMensual = null,Object? precioAnual = null,Object? stripePriceId = freezed,Object? activo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,precioMensual: null == precioMensual ? _self.precioMensual : precioMensual // ignore: cast_nullable_to_non_nullable
as double,precioAnual: null == precioAnual ? _self.precioAnual : precioAnual // ignore: cast_nullable_to_non_nullable
as double,stripePriceId: freezed == stripePriceId ? _self.stripePriceId : stripePriceId // ignore: cast_nullable_to_non_nullable
as String?,activo: null == activo ? _self.activo : activo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nombre, @JsonKey(name: 'precio_mensual')  double precioMensual, @JsonKey(name: 'precio_anual')  double precioAnual, @JsonKey(name: 'stripe_price_id')  String? stripePriceId,  bool activo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.nombre,_that.precioMensual,_that.precioAnual,_that.stripePriceId,_that.activo);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nombre, @JsonKey(name: 'precio_mensual')  double precioMensual, @JsonKey(name: 'precio_anual')  double precioAnual, @JsonKey(name: 'stripe_price_id')  String? stripePriceId,  bool activo)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.id,_that.nombre,_that.precioMensual,_that.precioAnual,_that.stripePriceId,_that.activo);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nombre, @JsonKey(name: 'precio_mensual')  double precioMensual, @JsonKey(name: 'precio_anual')  double precioAnual, @JsonKey(name: 'stripe_price_id')  String? stripePriceId,  bool activo)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.id,_that.nombre,_that.precioMensual,_that.precioAnual,_that.stripePriceId,_that.activo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Plan implements Plan {
  const _Plan({required this.id, required this.nombre, @JsonKey(name: 'precio_mensual') required this.precioMensual, @JsonKey(name: 'precio_anual') required this.precioAnual, @JsonKey(name: 'stripe_price_id') this.stripePriceId, required this.activo});
  factory _Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

@override final  int id;
@override final  String nombre;
@override@JsonKey(name: 'precio_mensual') final  double precioMensual;
@override@JsonKey(name: 'precio_anual') final  double precioAnual;
@override@JsonKey(name: 'stripe_price_id') final  String? stripePriceId;
@override final  bool activo;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.id, id) || other.id == id)&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.precioMensual, precioMensual) || other.precioMensual == precioMensual)&&(identical(other.precioAnual, precioAnual) || other.precioAnual == precioAnual)&&(identical(other.stripePriceId, stripePriceId) || other.stripePriceId == stripePriceId)&&(identical(other.activo, activo) || other.activo == activo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,nombre,precioMensual,precioAnual,stripePriceId,activo);

@override
String toString() {
  return 'Plan(id: $id, nombre: $nombre, precioMensual: $precioMensual, precioAnual: $precioAnual, stripePriceId: $stripePriceId, activo: $activo)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 int id, String nombre,@JsonKey(name: 'precio_mensual') double precioMensual,@JsonKey(name: 'precio_anual') double precioAnual,@JsonKey(name: 'stripe_price_id') String? stripePriceId, bool activo
});




}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nombre = null,Object? precioMensual = null,Object? precioAnual = null,Object? stripePriceId = freezed,Object? activo = null,}) {
  return _then(_Plan(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,precioMensual: null == precioMensual ? _self.precioMensual : precioMensual // ignore: cast_nullable_to_non_nullable
as double,precioAnual: null == precioAnual ? _self.precioAnual : precioAnual // ignore: cast_nullable_to_non_nullable
as double,stripePriceId: freezed == stripePriceId ? _self.stripePriceId : stripePriceId // ignore: cast_nullable_to_non_nullable
as String?,activo: null == activo ? _self.activo : activo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
