
import 'dart:async';

import 'project_model.dart';

abstract class ProjectRepository {
  Future<void> addNewProject(Project project);

  Future<void> deleteProject(Project project);

  Future<Stream<List<Project>>> projects();

  Future<void> updateProject(Project project);

}
