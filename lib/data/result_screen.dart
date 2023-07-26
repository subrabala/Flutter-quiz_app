import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/data/summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onRestart});
  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i],
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summary = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrect = summary
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                  'You answered $numCorrect out of $numTotalQuestions questions correctly'),
              const SizedBox(height: 30),
              Summary(summary),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: onRestart, child: const Text('Restart Quiz'))
            ])));
  }
}
