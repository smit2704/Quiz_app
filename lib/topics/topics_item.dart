import 'package:fireshipapp/shared/progress_bar.dart';
import 'package:fireshipapp/topics/drawer.dart';
import 'package:fireshipapp/topics/topics.dart';
import 'package:flutter/material.dart';

import '../services/models.dart';
class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({Key? key,required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: topic.img ,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) => TopicScreen(topic : topic))
              );
            },
            child: Column(
              children: [
                Flexible(
                  flex: 3,
                    child: SizedBox(
                      child: Image.asset(
                        'assets/covers/${topic.img}',
                        fit: BoxFit.contain,
                      ),
                    )
                ),
                Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Text(
                        topic.title,
                        style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    )),
                TopicProgress(topic: topic)
              ],
            ),
          ),
        ));
  }
}

class TopicScreen extends StatelessWidget {
  final Topic topic;
  const TopicScreen({Key? key,required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag : topic.img,
            child: Image.asset('assets/covers/${topic.img}',width: MediaQuery.of(context).size.width),
          ),
          Text(
            topic.title,
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,height: 2),
          ),
          QuizList(topic: topic)
        ],
      ),
    );
  }
}

