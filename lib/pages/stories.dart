import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';



class Story extends StatefulWidget {

  var data;

  Story({ super.key, required this.data});
  @override
  _Story createState() => _Story(this.data);
}

class _Story extends State<Story>{

  var data;

  _Story(this.data);

  final StoryController controller = StoryController();

  List<StoryItem> storyItems = [];

  bool _showObject = false;

  void initState() {
    super.initState();
    data.snapshots().listen((QuerySnapshot querySnapshot) {
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        print(doc.data());
        storyItems.add(StoryItem.pageImage(
          url: doc['url']!,
          controller: controller,
          duration: Duration(
            milliseconds: 3000,
          ),
        ));
      }
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _showObject = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: _showObject
              ?
                StoryView(
                  storyItems: storyItems,
                  controller: controller,
                  onComplete: () {
                    Navigator.of(context).pop();
                  },
                  onVerticalSwipeComplete: (v) {
                    if (v == Direction.down) {
                      Navigator.pop(context);
                    }
                  },
                ) : Center(child: CircularProgressIndicator(color: Colors.black,),),
      ));
  }
}