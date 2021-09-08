// import 'package:equatable/equatable.dart';
// import 'package:meta/meta.dart';
// import 'project_model.dart';

// @immutable
// abstract class ProjectEvent extends Equatable {
//   const ProjectEvent();

//   @override
//   List<Object> get props => [];
// }


// class ProjectEventLoad extends ProjectEvent {}

// class ProjectEventAdd extends ProjectEvent {
//   final Project project;

//   const ProjectEventAdd(this.project);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'AddProject { project: $project }';
// }

// class ProjectEventUpdate extends ProjectEvent {
//   final Project updatedProject;

//   const ProjectEventUpdate(this.updatedProject);

//   @override
//   List<Object> get props => [updatedProject];

//   @override
//   String toString() => 'UpdateProject { updatedProject: $updatedProject }';
// }

// class ProjectEventDelete extends ProjectEvent {
//   final Project project;

//   const ProjectEventDelete(this.project);

//   @override
//   List<Object> get props => [project];

//   @override
//   String toString() => 'DeleteProject { project: $project }';
// }

// class ProjectEventUpdated extends ProjectEvent {
//   final List<Project> projects;
//   final String parentId;
//   final String selectedId;
//   final String lastSelectId;

//   const ProjectEventUpdated(this.projects, {this.parentId, this.selectedId, this.lastSelectId});

//   @override
//   List<Object> get props => [projects, parentId, selectedId, lastSelectId];
// }
