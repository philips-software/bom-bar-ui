/*
 * This software and associated documentation files are
 *
 * Copyright © 2020-2020 Koninklijke Philips N.V.
 *
 * and is made available for use within Philips and/or within Philips products.
 *
 * All Rights Reserved
 */

import 'dart:developer';

import 'package:flutter/material.dart';

import 'dependency/dependency_screen.dart';
import 'packages/packages_screen.dart';
import 'project/project_screen.dart';
import 'projects/projects_screen.dart';

const projectsRoute = '/projects';
const projectRoute = '/project';
const packagesRoute = '/packages';
const dependencyRoute = '/dependency';

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => _screenFromRoute(context, settings),
    );
  }

  static Widget _screenFromRoute(BuildContext context, RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case projectsRoute:
        return ProjectsScreen();
      case packagesRoute:
        return PackagesScreen();
      case projectRoute:
        return ProjectScreen();
      case dependencyRoute:
        return DependencyScreen();
      default:
        log('No route defined for "${settings.name}"');
        return null;
    }
  }
}
