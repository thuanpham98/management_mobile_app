// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import './bloc.dart';
// import 'project_repostiory.dart';

// class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
//   final ProjectRepository _projectRepository;
//   StreamSubscription _projectSubscription;

//   ProjectBloc({@required ProjectRepository projectRepository})
//       : assert(projectRepository != null),
//         _projectRepository = projectRepository,
//         super(ProjectStateLoading());

//   @override
//   Stream<ProjectState> mapEventToState(
//     ProjectEvent event,
//   ) async* {
//     if (event is ProjectEventLoad) {
//       yield* _mapLoadProjectToState();
//     } else if (event is ProjectEventAdd) {
//       yield* _mapAddProjectToState(event);
//     } else if (event is ProjectEventUpdate) {
//       yield* _mapUpdateProjectToState(event);
//     } else if (event is ProjectEventDelete) {
//       yield* _mapDeleteProjectToState(event);
//     } else if (event is ProjectEventUpdated) {
//       yield* _mapProjectUpdateToState(event);
//     }
//   }

//   Stream<ProjectState> _mapLoadProjectToState() async* {
//     _projectSubscription?.cancel();
//     _projectSubscription = (await _projectRepository.projects()).listen(
//       (projects) {
//         add(ProjectEventUpdated(projects));
//       },
//     );
//   }

//   Stream<ProjectState> _mapAddProjectToState(ProjectEventAdd event) async* {
//     _projectRepository.addNewProject(event.project);
//   }

//   Stream<ProjectState> _mapUpdateProjectToState(
//       ProjectEventUpdate event) async* {
//     _projectRepository.updateProject(event.updatedProject);
//   }

//   Stream<ProjectState> _mapDeleteProjectToState(
//       ProjectEventDelete event) async* {
//     _projectRepository.deleteProject(event.project);
//   }

//   Stream<ProjectState> _mapProjectUpdateToState(
//       ProjectEventUpdated event) async* {
//     yield ProjectStateLoaded(event.projects, event.parentId, event.selectedId, event.lastSelectId);
//   }

//   @override
//   Future<void> close() {
//     _projectSubscription?.cancel();
//     return super.close();
//   }
// }
