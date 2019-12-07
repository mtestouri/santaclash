import 'package:flutter/material.dart';
import 'package:smashlike/smash_engine/screen_util.dart';
import 'package:smashlike/main.dart';
import 'package:smashlike/menu.dart';

class Join extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> posts = ["bite","adrien","oups","Mehdi","Sami","zizi"];
    ScreenUtil.init(context, screenOrientation: "landscape");
    return Scaffold(
      body: Container(
        height: ScreenUtil.screenHeight,
        width: ScreenUtil.screenWidth,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menus/selectback.png'),
            fit: BoxFit.fill,

          ),
        ),
        child:Stack(
            children:[
              Align(
                alignment: Alignment(0, 0),
                child:Container(
                  height: ScreenUtil.unitHeight*50,
                  width: ScreenUtil.unitWidth*50,

                  child: DynamicBlueList(posts),
                ),
              ),

            ]
        ),
      ),
    );
  }
}


class DynamicBlueList extends StatefulWidget {
  final List<String> blueList;

  DynamicBlueList(this.blueList);

  @override
  DynamicBlueListState createState() => DynamicBlueListState();
}

class DynamicBlueListState extends State<DynamicBlueList> {
  List<String> blueList;

  @override
  void initState() {
    super.initState();
    blueList = widget.blueList;
  }

  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var post = blueList[index];
        return ListTile(
          title: Text(post, textAlign: TextAlign.center),
          onTap: () {
            blueList=["a","b","c","d","e"];
            print(index);
            setState((){});
          },
        );
      },
      itemCount: blueList.length,

    );
  }
}



