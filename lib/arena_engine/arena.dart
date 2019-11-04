import 'package:smashlike/arena_engine/asset.dart';
import 'package:flutter/material.dart';

class Arena extends StatefulWidget {
  int width, height;

  @override
  ArenaState createState() => ArenaState();
}

class ArenaState extends State<Arena> {
  List<Asset> _assets;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: _assets
    );
  }
}

class DebugArena extends Arena {

}