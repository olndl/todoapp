import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/dimension.dart';
import 'list_of_tiles.dart';

class CardBase extends StatelessWidget {
  const CardBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
        top: Dim.height(context) / 40,
        left: Dim.width(context) / 56,
        right: Dim.width(context) / 56,
        bottom: Dim.height(context) / 40,
      ),
      child: const ListOfTiles()
    );
  }
}
