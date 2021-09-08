// import 'package:equatable/equatable.dart';
// import 'project_model.dart';
// import 'project_repostiory.dart';

// abstract class ProjectState extends Equatable {
//   const ProjectState();

//   @override
//   List<Object> get props => [];
// }

// class ProjectStateLoading extends ProjectState {}

// class ProjectStateLoaded extends ProjectState {
//   final List<Project> projects;
//   final String parentId;
//   final String selectedId;
//   final String lastSelectId;

//   const ProjectStateLoaded(
//       [this.projects = const [], this.parentId, this.selectedId, this.lastSelectId]);

//   @override
//   List<Object> get props => [projects, parentId, selectedId];

//   @override
//   String toString() =>
//       'ProjectStateLoaded { projects: $projects, parentId $parentId, selectedId $selectedId, lastSelectId $lastSelectId }';
// }

// class ProjectStateNotLoaded extends ProjectState {}
