import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_member.freezed.dart';
part 'team_member.g.dart';

@freezed
abstract class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    @JsonKey(name: 'store_id') required String storeId,
    required String nombre,
    required String correo,
    required String rol, // cajero, administrador
    required bool activo,
  }) = _TeamMember;

  factory TeamMember.fromJson(Map<String, dynamic> json) => _$TeamMemberFromJson(json);
}
