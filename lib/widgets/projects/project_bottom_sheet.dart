// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import '../../blocs/project/bloc.dart';
// import '../../blocs/project/project_model.dart';
// import 'package:get_it/get_it.dart';
// import 'project_extra_menu.dart';
// import 'project.i18n.dart';

// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import '../../services/localstorage_service.dart';

// class ProjectBottomSheet extends StatefulWidget {
//   final projectLevel;
//   final Widget icon;
//   final List<ProjectExtraMenu> extraMenu;
//   final String parentId;
//   final String selectedId;
//   final BuildContext customContext;
//   final Function onSelected;
//   final Function onSetting;

//   ProjectBottomSheet(
//       {this.parentId,
//       this.icon,
//       this.extraMenu = const [],
//       this.customContext,
//       this.selectedId,
//       this.onSelected,
//       this.onSetting,
//       this.projectLevel = 0});

//   @override
//   _ProjectBottomSheetState createState() => _ProjectBottomSheetState();
// }

// class _ProjectBottomSheetState extends State<ProjectBottomSheet> {
//   String selectedId;
//   bool isDarkMode;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       selectedId = widget.selectedId;
//     });
//   }

//   Widget _divider() {
//     return Divider(
//       color: Theme.of(context).dividerColor,
//       height: 4.0,
//     );
//   }

//   Widget _buildItem(BuildContext context, String text,
//       {bool isChecked,
//       Function onTap,
//       Function onSetting,
//       Color textColor,
//       Widget icon}) {
//     return Neumorphic(
//       // padding: EdgeInsets.fromLTRB(10, 0, 10, bottom),
//       margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//       child: Row(
//       children: <Widget>[
//         Expanded(
//           flex: 2,
//           child: ListTile(
//             leading: Container(
//               padding: EdgeInsets.all(4.0),
//               decoration: isChecked == true
//                   ? BoxDecoration(
//                       color: Theme.of(context).buttonColor.withOpacity(0.5),
//                       border: Border.all(color: Theme.of(context).errorColor),
//                       borderRadius: BorderRadius.all(Radius.circular(4.0)))
//                   : null,
//               child: icon ?? Icon(Icons.menu),
//             ),
//             title: Text(
//               text,
//               style: TextStyle(color: textColor),
//             ),
//             onTap: onTap,
//           ),
//         ),
//         onSetting != null
//             ? Expanded(
//                 flex: 1,
//                 child: Container(
//                   padding: EdgeInsets.only(right: 10.0),
//                   alignment: Alignment.centerRight,
//                   child: IconButton(
//                     icon: Icon(Feather.settings),
//                     onPressed: onSetting,
//                   ),
//                 ),
//               )
//             : Container()
//       ],
//     ),
//     style: NeumorphicStyle(
//         shape: NeumorphicShape.concave,
//         boxShape:
//           NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
//         depth: (onSetting == null)? 0 : 2,
//         lightSource: LightSource.topLeft,
//         color: (onSetting == null)? Colors.transparent :Theme.of(context).backgroundColor,
//         intensity: (onSetting == null)? 0 : 1,
//         surfaceIntensity: 0,
//         shadowLightColor: Colors.white.withOpacity((isDarkMode)? 0.28 : 0.8),
//         shadowDarkColor: Colors.black.withOpacity((isDarkMode)? 0.7 : 0.28),
//       ),
//     );
//   }

//   void _onSetting(String id) {
//     if (widget.onSetting != null) {
//       widget.onSetting(id, context);
//     }
//   }

//   void _onTap(List<Project> projects, String _selectedId, String _parentId) {
//     if (widget.onSelected != null) {
//       widget.onSelected(projects, _selectedId, _parentId);
//     }
//     setState(() {
//       selectedId = _selectedId;
//     });
//   }

//   Widget _buildExtraMenu(
//       BuildContext context, String name, Widget bottomSheet, Widget icon) {
//     return _buildItem(context, name,
//         textColor: Theme.of(context).textSelectionColor,
//         icon: icon,
//         onTap: () => showModalBottomSheet(
//             context: widget.customContext ?? context,
//             backgroundColor: Theme.of(context).primaryColorLight,
//             isScrollControlled: true,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: const Radius.circular(20.0),
//                 topRight: const Radius.circular(20.0),
//               ),
//             ),
//             builder: (BuildContext context) => bottomSheet));
//   }

//   Widget _buildList(BuildContext context) {
//     return BlocProvider<ProjectBloc>(
//       create: (context) => GetIt.I<ProjectBloc>(),
//       child: BlocBuilder<ProjectBloc, ProjectState>(
//         builder: (BuildContext context, ProjectState state) {
//           if (state is ProjectStateLoaded && state.projects != null) {
//             var projects = state.projects.where((element) {
//               return element.parentId == widget.parentId;
//             });

//             var listItems = ListView.separated(
//               itemCount: projects.length + widget.extraMenu.length,
//               itemBuilder: (BuildContext context, int index) {
//                 if (widget.extraMenu.length > 0 && index >= projects.length) {
//                   ProjectExtraMenu menu =
//                       widget.extraMenu[index - projects.length];
//                   return _buildExtraMenu(
//                       context, menu.name, menu.content, menu.icon);
//                 }

//                 if (index >= projects.length) {
//                   return Container();
//                 }
//                 var project = projects.elementAt(index);

//                 var isChecked = project.id == selectedId;

//                 return _buildItem(context, project.name,
//                     isChecked: isChecked,
//                     icon: widget.icon,
//                     onSetting: () => _onSetting(project.id),
//                     onTap: () =>
//                         _onTap(state.projects, project.id, project.parentId));
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return Container(height: 10,);
//                 // return _divider();
//               },
//             );

//             return listItems;
//           }
//           return Center(
//             child: Container(
//               height: 150,
//               width: 150,
//               alignment: Alignment.topCenter,
//               child: CircularProgressIndicator(),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     isDarkMode = GetIt.I<LocalStorageService>().darkMode;
//     return Container(
//       height: MediaQuery.of(context).size.height / 2,
//       padding: EdgeInsets.only(top: 10.0),
//       color: Colors.transparent,
//       child: _buildList(context),
//       // decoration: BoxDecoration(
//       //   shape: BoxShape.rectangle
//       //   // borderRadius: BorderRadiusGeometry.
//       // ),
//     );
//   }
// }
