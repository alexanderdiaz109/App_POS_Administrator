// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sale_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SaleDetailItem {

 String get nombre; int get cantidad; double get precioUnitario;
/// Create a copy of SaleDetailItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailItemCopyWith<SaleDetailItem> get copyWith => _$SaleDetailItemCopyWithImpl<SaleDetailItem>(this as SaleDetailItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetailItem&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario));
}


@override
int get hashCode => Object.hash(runtimeType,nombre,cantidad,precioUnitario);

@override
String toString() {
  return 'SaleDetailItem(nombre: $nombre, cantidad: $cantidad, precioUnitario: $precioUnitario)';
}


}

/// @nodoc
abstract mixin class $SaleDetailItemCopyWith<$Res>  {
  factory $SaleDetailItemCopyWith(SaleDetailItem value, $Res Function(SaleDetailItem) _then) = _$SaleDetailItemCopyWithImpl;
@useResult
$Res call({
 String nombre, int cantidad, double precioUnitario
});




}
/// @nodoc
class _$SaleDetailItemCopyWithImpl<$Res>
    implements $SaleDetailItemCopyWith<$Res> {
  _$SaleDetailItemCopyWithImpl(this._self, this._then);

  final SaleDetailItem _self;
  final $Res Function(SaleDetailItem) _then;

/// Create a copy of SaleDetailItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nombre = null,Object? cantidad = null,Object? precioUnitario = null,}) {
  return _then(_self.copyWith(
nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as int,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleDetailItem].
extension SaleDetailItemPatterns on SaleDetailItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetailItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetailItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetailItem value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetailItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetailItem value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetailItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String nombre,  int cantidad,  double precioUnitario)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetailItem() when $default != null:
return $default(_that.nombre,_that.cantidad,_that.precioUnitario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String nombre,  int cantidad,  double precioUnitario)  $default,) {final _that = this;
switch (_that) {
case _SaleDetailItem():
return $default(_that.nombre,_that.cantidad,_that.precioUnitario);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String nombre,  int cantidad,  double precioUnitario)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetailItem() when $default != null:
return $default(_that.nombre,_that.cantidad,_that.precioUnitario);case _:
  return null;

}
}

}

/// @nodoc


class _SaleDetailItem extends SaleDetailItem {
  const _SaleDetailItem({required this.nombre, required this.cantidad, required this.precioUnitario}): super._();
  

@override final  String nombre;
@override final  int cantidad;
@override final  double precioUnitario;

/// Create a copy of SaleDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailItemCopyWith<_SaleDetailItem> get copyWith => __$SaleDetailItemCopyWithImpl<_SaleDetailItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetailItem&&(identical(other.nombre, nombre) || other.nombre == nombre)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario));
}


@override
int get hashCode => Object.hash(runtimeType,nombre,cantidad,precioUnitario);

@override
String toString() {
  return 'SaleDetailItem(nombre: $nombre, cantidad: $cantidad, precioUnitario: $precioUnitario)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailItemCopyWith<$Res> implements $SaleDetailItemCopyWith<$Res> {
  factory _$SaleDetailItemCopyWith(_SaleDetailItem value, $Res Function(_SaleDetailItem) _then) = __$SaleDetailItemCopyWithImpl;
@override @useResult
$Res call({
 String nombre, int cantidad, double precioUnitario
});




}
/// @nodoc
class __$SaleDetailItemCopyWithImpl<$Res>
    implements _$SaleDetailItemCopyWith<$Res> {
  __$SaleDetailItemCopyWithImpl(this._self, this._then);

  final _SaleDetailItem _self;
  final $Res Function(_SaleDetailItem) _then;

/// Create a copy of SaleDetailItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nombre = null,Object? cantidad = null,Object? precioUnitario = null,}) {
  return _then(_SaleDetailItem(
nombre: null == nombre ? _self.nombre : nombre // ignore: cast_nullable_to_non_nullable
as String,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as int,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$SaleDetail {

 String get id; String get folio; double get total; String get metodoPago; DateTime get fecha; List<SaleDetailItem> get items;
/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaleDetailCopyWith<SaleDetail> get copyWith => _$SaleDetailCopyWithImpl<SaleDetail>(this as SaleDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.folio, folio) || other.folio == folio)&&(identical(other.total, total) || other.total == total)&&(identical(other.metodoPago, metodoPago) || other.metodoPago == metodoPago)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,id,folio,total,metodoPago,fecha,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SaleDetail(id: $id, folio: $folio, total: $total, metodoPago: $metodoPago, fecha: $fecha, items: $items)';
}


}

/// @nodoc
abstract mixin class $SaleDetailCopyWith<$Res>  {
  factory $SaleDetailCopyWith(SaleDetail value, $Res Function(SaleDetail) _then) = _$SaleDetailCopyWithImpl;
@useResult
$Res call({
 String id, String folio, double total, String metodoPago, DateTime fecha, List<SaleDetailItem> items
});




}
/// @nodoc
class _$SaleDetailCopyWithImpl<$Res>
    implements $SaleDetailCopyWith<$Res> {
  _$SaleDetailCopyWithImpl(this._self, this._then);

  final SaleDetail _self;
  final $Res Function(SaleDetail) _then;

/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? folio = null,Object? total = null,Object? metodoPago = null,Object? fecha = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,folio: null == folio ? _self.folio : folio // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,metodoPago: null == metodoPago ? _self.metodoPago : metodoPago // ignore: cast_nullable_to_non_nullable
as String,fecha: null == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SaleDetailItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SaleDetail].
extension SaleDetailPatterns on SaleDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SaleDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SaleDetail value)  $default,){
final _that = this;
switch (_that) {
case _SaleDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SaleDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String folio,  double total,  String metodoPago,  DateTime fecha,  List<SaleDetailItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
return $default(_that.id,_that.folio,_that.total,_that.metodoPago,_that.fecha,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String folio,  double total,  String metodoPago,  DateTime fecha,  List<SaleDetailItem> items)  $default,) {final _that = this;
switch (_that) {
case _SaleDetail():
return $default(_that.id,_that.folio,_that.total,_that.metodoPago,_that.fecha,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String folio,  double total,  String metodoPago,  DateTime fecha,  List<SaleDetailItem> items)?  $default,) {final _that = this;
switch (_that) {
case _SaleDetail() when $default != null:
return $default(_that.id,_that.folio,_that.total,_that.metodoPago,_that.fecha,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _SaleDetail implements SaleDetail {
  const _SaleDetail({required this.id, required this.folio, required this.total, required this.metodoPago, required this.fecha, required final  List<SaleDetailItem> items}): _items = items;
  

@override final  String id;
@override final  String folio;
@override final  double total;
@override final  String metodoPago;
@override final  DateTime fecha;
 final  List<SaleDetailItem> _items;
@override List<SaleDetailItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaleDetailCopyWith<_SaleDetail> get copyWith => __$SaleDetailCopyWithImpl<_SaleDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaleDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.folio, folio) || other.folio == folio)&&(identical(other.total, total) || other.total == total)&&(identical(other.metodoPago, metodoPago) || other.metodoPago == metodoPago)&&(identical(other.fecha, fecha) || other.fecha == fecha)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,id,folio,total,metodoPago,fecha,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SaleDetail(id: $id, folio: $folio, total: $total, metodoPago: $metodoPago, fecha: $fecha, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SaleDetailCopyWith<$Res> implements $SaleDetailCopyWith<$Res> {
  factory _$SaleDetailCopyWith(_SaleDetail value, $Res Function(_SaleDetail) _then) = __$SaleDetailCopyWithImpl;
@override @useResult
$Res call({
 String id, String folio, double total, String metodoPago, DateTime fecha, List<SaleDetailItem> items
});




}
/// @nodoc
class __$SaleDetailCopyWithImpl<$Res>
    implements _$SaleDetailCopyWith<$Res> {
  __$SaleDetailCopyWithImpl(this._self, this._then);

  final _SaleDetail _self;
  final $Res Function(_SaleDetail) _then;

/// Create a copy of SaleDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? folio = null,Object? total = null,Object? metodoPago = null,Object? fecha = null,Object? items = null,}) {
  return _then(_SaleDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,folio: null == folio ? _self.folio : folio // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,metodoPago: null == metodoPago ? _self.metodoPago : metodoPago // ignore: cast_nullable_to_non_nullable
as String,fecha: null == fecha ? _self.fecha : fecha // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SaleDetailItem>,
  ));
}


}

// dart format on
