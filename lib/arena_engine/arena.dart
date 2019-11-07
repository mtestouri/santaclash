import 'package:smashlike/arena_engine/asset.dart';
import 'package:flutter/material.dart';

class Arena extends StatefulWidget {
  final ArenaState _state = ArenaState();

  Arena(List<Asset> assets) {
    this._state._assets = assets;
  }

  List<Asset> get assets => _state._assets;

  @override
  ArenaState createState() => _state;
}

class ArenaState extends State<Arena> {
  List<Asset> _assets = new List<Asset>();

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: _assets
    );
  }
}
