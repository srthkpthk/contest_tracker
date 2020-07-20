import 'package:competition_tracker/src/data/bloc/details_bloc.dart';
import 'package:competition_tracker/src/util/entriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details_screen.dart';

class CPHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        backgroundColor: Colors.black,
        body: GridView.builder(
            itemCount: HelperClass().entries.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return _buildGridChild(HelperClass().entries[index].id, HelperClass().entries[index].icon,
                  HelperClass().entries[index].name, context);
            }));
  }

  _buildGridChild(int id, String icon, String name, BuildContext context) => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BlocProvider<DetailsBloc>(
                      create: (context) => DetailsBloc()..add(GetDetails(id)), child: DetailsScreen(id, name, icon)))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                SizedBox.expand(
                  child: Hero(
                      tag: id,
                      child: Image(
                        image: AssetImage(icon),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(.5), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          stops: [.01, .3],
                          end: Alignment.topCenter)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Hero(
                          tag: name,
                          child: Material(
                            color: Colors.transparent,
                            child: Text(name,
                                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                          ))),
                ),
              ],
            ),
          ),
        ),
      );
}
