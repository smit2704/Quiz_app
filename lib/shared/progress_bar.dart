import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/models.dart';

class AnimatedProgressbar extends StatelessWidget {
  final double value;
  final double height;

  const AnimatedProgressbar({
    Key? key,
    required this.value,
    this.height = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints box) {
      return Container(
        padding: EdgeInsets.all(10),
        width: box.maxWidth,
        child: Stack(
          children: [
            Container(
              height: height,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  )),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              height: height,
              width: box.maxWidth * _floor(value),
              decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  )),
            ),
          ],
        ),
      );
    });
  }
}

_floor(double value, [min = 0.0]) {
  return value.sign <= min ? min : value;
}

_colorGen(double value) {
  int rgb = (value * 255).toInt();
  return Colors.deepOrange.withGreen(rgb).withRed(255 - rgb);
}

class TopicProgress extends StatelessWidget {
  const TopicProgress({Key? key, required this.topic}) : super(key: key);

  final Topic topic;
  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    return Row(
      children: [
        _progressCount(report, topic),
        Expanded(
          child: AnimatedProgressbar(
              value: _calculateProgress(topic, report),
              height: 8),
        ),
      ],
    );
  }
}

Widget _progressCount(Report report, Topic topic) {
  return Padding(
    padding: EdgeInsets.only(left: 8),
    child: Text(
      '${report.topics[topic.id]?.length ?? 0} /${topic.quizzes.length}',
      style: TextStyle(fontSize: 10, color:  Colors.grey),
    ),
  );
}

double _calculateProgress(Topic topic,Report report){
  try{
    int totalQuizzes = topic.quizzes.length;
    int completedQuizzes = report.topics[topic.id].length;
    return completedQuizzes/totalQuizzes;
  }
  catch(err){
  return 0.0;}
}
