// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../services/services.dart';
import 'project_entity.dart';

@immutable
class Project extends Equatable {
  final String? id;
  final String? notes;
  final String? name;
  final String? parentId;
  final int? type;
  final Map<String,dynamic>? access;

  Project({
    this.id,
    this.name,
    this.notes,
    this.parentId,
    this.type,
    this.access
    });

  @override
  List<Object?> get props => [id,name,notes,parentId,type,access];

  Project copyWith(
      {String? id,
      String? name,
      String? notes,
      String? parentId,
      int? type,
      Map<String,dynamic>? access }) {
    return Project(
        name: name ?? this.name,
        notes: notes ?? this.notes,
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        type: type ?? this.type,
        access: access ?? this.access);
  }

  @override
  String toString() {
    return 'Project { id: $id, name: $name, notes: $notes, parentId: $parentId, type: $type}';
  }

  // ProjectEntity toEntity() {
  //   return ProjectEntity(
  //       id: id,
  //       name: name,
  //       notes: notes,
  //       parentId: parentId,
  //       location: location,
  //       type: type);
  // }

  // static Project fromEntity(ProjectEntity entity) {
  //   return Project(
  //     id: entity.id,
  //     name: entity.name ?? false,
  //     notes: entity.notes,
  //     parentId: entity.parentId,
  //     type: entity.type,
  //     location: entity.location,
  //   );
  // }
}