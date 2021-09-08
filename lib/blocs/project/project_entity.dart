// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String? id;
  final String? notes;
  final String? name;
  final String? parentId;
  final int? type;
  final Map<String,dynamic>? access;

  ProjectEntity({
    this.id,
    this.name,
    this.notes,
    this.parentId,
    this.type,
    this.access
    });

  @override
  String toString() {
    return 'ProjectEntity { id: $id, name: $name, parent_id: $parentId, type: $type }';
  }

  @override
  List<Object?> get props => [id,name,notes,parentId,type,access];

  static ProjectEntity fromJson(Map<String, Object> json) {
    return ProjectEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      notes: json['notes'] as String,
      type: json['type'] as int,
      parentId: json['parent_id'] as String,
      access: json['access'] as Map<String,dynamic>
    );
  }

  // static ProjectEntity fromSnapshot(DocumentSnapshot snap) {
  //   return ProjectEntity(
  //     id: snap.id,
  //     name: snap.data()['name'],
  //     photo: snap.data()['photo'],
  //     notes: snap.data()['notes'],
  //     type: snap.data()['type'],
  //     parentId: snap.data()['parent_id'],
  //     location: snap.data()['location'],
  //     isActive: snap.data()['is_active'],
  //   );
  // }

  Map<String, Object> toDocument() {
    return {
      "id": id!,
      "name": name!,
      "notes": notes!,
      "type": type!,
      "parentId": parentId!,
      "access": access!
    };
  }
}
