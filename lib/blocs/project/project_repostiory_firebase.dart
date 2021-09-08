// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'project_model.dart';
// import 'project_repostiory.dart';
// import 'project_entity.dart';

// class ProjectRepositoryFirebase implements ProjectRepository {
//   final projectCollection = FirebaseFirestore.instance.collection('iot_projects');

//   @override
//   Future<void> addNewProject(Project project) {
//     return projectCollection.add(project.toEntity().toDocument());
//   }

//   @override
//   Future<void> deleteProject(Project project) async {
//     return projectCollection.doc(project.id).delete();
//   }

//   @override
//   Future<Stream<List<Project>>> projects() async {
//     String currentUserId = (FirebaseAuth.instance.currentUser)?.uid;
//     final snapshots = projectCollection.where('access.$currentUserId', isGreaterThan: 0).snapshots();
//     return snapshots.map((snapshot) {
//       return snapshot.docs
//           .map((doc) => Project.fromEntity(ProjectEntity.fromSnapshot(doc)))
//           .toList();
//     });
//   }

//   @override
//   Future<void> updateProject(Project update) {
//     return projectCollection
//         .doc(update.id)
//         .update(update.toEntity().toDocument());
//   }
// }
