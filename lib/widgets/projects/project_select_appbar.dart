// import 'package:pas_app/services/localstorage_service.dart';

// import '../../blocs/project/project_model.dart';
// import '../../service_locator.dart';
// import '../../services/navigation_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import '../../blocs/project/bloc.dart';
// import 'project_extra_menu.dart';
// import 'project_bottom_sheet.dart';
// import 'project.i18n.dart';
// import 'package:pas_app/service_locator.dart';

// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:pas_app/services/theme/styles.dart';
// import 'package:pas_app/constants/background.dart';

// class ProjectSelectAppBar extends StatefulWidget with PreferredSizeWidget {
//   final String name;
//   final Widget icon;
//   final Widget itemIcon;
//   final BuildContext customContext; //using for override bottom bar
//   final String selectedId;
//   final String parentId;
//   final Function onSetting;
//   final Function onSelected;
//   final List<ProjectExtraMenu> extraMenu;

//   ProjectSelectAppBar(
//       {this.name,
//       this.icon,
//       this.customContext,
//       this.selectedId,
//       this.parentId,
//       this.onSetting,
//       this.onSelected,
//       this.extraMenu,
//       this.itemIcon});

//   @override
//   _ProjectSelectAppBarState createState() => _ProjectSelectAppBarState();

//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

// class _ProjectSelectAppBarState extends State<ProjectSelectAppBar> {
//   String selectedId;
//   String parentId;
//   bool isDarkMode;

//   @override
//   void initState() {
//     print("open selec appbar");
//     super.initState();
//     setState(() {
//       selectedId = widget.selectedId;
//       parentId = widget.parentId;
//     });
//   }

//   void _onSelected(
//       List<Project> projects, String _selectedId, String _parentId) {
//     if (widget.onSelected != null) {
//       widget.onSelected(projects, _selectedId, _parentId);
//     }
//     setState(() {
//       selectedId = _selectedId;
//       parentId = _parentId;
//     });
//   }

//   Widget _buildHomeIcon(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(left: 10),
//       child: NeumorphicButton(
//           padding: EdgeInsets.all(5),
//           margin: EdgeInsets.all(0),
//           onPressed: () async {
//             await Future.delayed(Duration(milliseconds: 300));
//             await GetIt.I<NavigationService>()
//                 .showBottomSheet(
//                     builder: (BuildContext context) => ProjectBottomSheet(
//                         extraMenu: widget.extraMenu,
//                         icon: widget.itemIcon ?? Icon(Icons.home),
//                         parentId: parentId,
//                         customContext: widget.customContext,
//                         selectedId: selectedId,
//                         onSetting: widget.onSetting,
//                         onSelected: _onSelected),
//                     context: widget.customContext ?? context)
//                 .whenComplete(() =>
//                     log.v('ProjectSelectAppBar/showModalBottomSheet/closed'));
//           },
//           style: NeumorphicStyle(
//             shape: NeumorphicShape.concave,
//             boxShape: NeumorphicBoxShape.circle(),
//             depth: 1.5,
//             lightSource: LightSource.topLeft,
//             color: Colors.transparent,
//             intensity: (isDarkMode) ? 1 : 1,
//             surfaceIntensity: (isDarkMode) ? 0.1 : 0,
//             shadowLightColor: Colors.white.withOpacity(isDarkMode ? 0.28 : 0.8),
//             shadowDarkColor: Colors.black.withOpacity(isDarkMode ? 0.7 : 0.28),
//           ),
//           child: widget.icon
//           // Container(
//           //   padding: EdgeInsets.all(0),
//           //   margin: EdgeInsets.all(0),
//           //   alignment: Alignment.center,
//           //   child: Text("...",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900),textAlign: TextAlign.center,)
//           // ),
//           ),
//       // Container(
//       //   alignment: new FractionalOffset(0.0, 0.5),
//       //   decoration: BoxDecoration(
//       //       shape: BoxShape.circle, color: Theme.of(context).focusColor),
//       //   child: IconButton(
//       //     icon: widget.icon ?? Icon(Icons.home),
//       //     onPressed: () {
//       // var bottomSheetController = GetIt.I<NavigationService>()
//       //     .showBottomSheet(
//       //         builder: (BuildContext context) => ProjectBottomSheet(
//       //             extraMenu: widget.extraMenu,
//       //             icon:
//       //                 widget.itemIcon ?? Icon(Icons.home),
//       //             parentId: parentId,
//       //             customContext: widget.customContext,
//       //             selectedId: selectedId,
//       //             onSetting: widget.onSetting,
//       //             onSelected: _onSelected),
//       //         context: widget.customContext ?? context);

//       // bottomSheetController.whenComplete(() {
//       //     log.v('ProjectSelectAppBar/showModalBottomSheet/closed');
//       // });
//       //     },
//       //   ),
//       // ),
//     );
//   }

//   Widget _buildHomeTitle(BuildContext context) {
//     return BlocProvider<ProjectBloc>(
//       create: (context) => GetIt.I<ProjectBloc>(),
//       child: BlocBuilder<ProjectBloc, ProjectState>(
//         builder: (BuildContext context, ProjectState state) {
//           if (state is ProjectStateLoaded && state.projects != null) {
//             Project selectedItem;
//             log.v('parentId: $parentId');
//             log.v('selectedId: $selectedId');
//             if (state.parentId != null && state.parentId != selectedId) {
//               log.v('Widget: ${widget.name}, Parentid=$parentId');
//             }
//             if (widget.parentId != null) {
//               parentId = widget.parentId;
//             }

//             log.v(
//                 'Widget: ${widget.name} widget.parentId $parentId, widget.selectedId $selectedId');

//             do {
//               var filteredItems = state.projects.where((element) {
//                 return (element.parentId == parentId);
//               }).toList();
//               log.d("parentId = $parentId");
//               log.d("filteredItems = $filteredItems");
//               if (filteredItems == null) {
//                 selectedItem = null;
//                 break;
//               }
//               if (filteredItems.length == 0) {
//                 selectedItem = null;
//                 break;
//               }
//               selectedItem = filteredItems[0].copyWith();
//               log.d("selectedItem = $selectedItem");

//               if (selectedId == null) {
//                 selectedId = selectedItem.id;
//                 widget.onSelected(
//                     state.projects, selectedId, selectedItem.parentId);
//                 break;
//               }

//               var selectedItems = filteredItems.where((element) {
//                 return (element.id == selectedId);
//               }).toList();
//               log.d("selectedItems = $selectedItems");

//               if (selectedItems.length == 0) {
//                 selectedId = selectedItem.id;
//                 widget.onSelected(
//                     state.projects, selectedId, selectedItem.parentId);
//                 break;
//               }
//               if (selectedId != selectedItems[0].id) {
//                 selectedId = selectedItem.id;
//                 widget.onSelected(
//                     state.projects, selectedId, selectedItem.parentId);
//                 break;
//               }
//               selectedItem = selectedItems[0];
//               break;
//             } while (true);

//             return Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     selectedItem != null
//                         ? ((selectedItem.name.length > 12)
//                             ? selectedItem.name.substring(0, 12) + "..."
//                             : selectedItem.name)
//                         : "No project found".i18n,
//                     style: TextStyle(
//                       color: isDarkMode ? Colors.blue : Colors.green,
//                     ),
//                   ),
//                 ]);
//           }

//           return Container(
//             alignment: Alignment.topLeft,
//             child: Text(
//               'Loading...'.i18n,
//               style: TextStyle(color: Theme.of(context).accentColor),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     isDarkMode = GetIt.I<LocalStorageService>().darkMode;
//     return AppBar(
//       // flexibleSpace: Container(
//       // decoration: BoxDecoration(
//       // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
//       // color: isDarkMode? Colors.blue : Colors.green,
//       // gradient: AppBackground.gradientBackground(Colors.blue),
//       //   ),
//       // ),
//       // elevation: 0,
//       backgroundColor: Theme.of(context).backgroundColor,
//       title: _buildHomeTitle(context),
//       leading: _buildHomeIcon(context),
//     );
//   }
// }
