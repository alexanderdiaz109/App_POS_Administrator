import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_entry.freezed.dart';
part 'audit_entry.g.dart';

@freezed
abstract class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required String id,
    required String usuarioNombre,
    required String accion,
    required String tipo, // normal, critico
    required DateTime fecha,
  }) = _AuditEntry;
  
  factory AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);
}
