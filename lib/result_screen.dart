import 'package:flutter/material.dart';
import 'package:quizapp/data/questions.dart';
import 'package:quizapp/questions_summary/questions_smmary.dart';

class ResultsScreen extends StatelessWidget{
  const ResultsScreen({super.key,required this.chosenAnswers,required this.onRestart});

  final void Function() onRestart;
  final List<String> chosenAnswers;

List<Map<String,Object>> getSummaryData()
{
final List<Map<String,Object>> summary=[];

  for (var i=0 ;i<chosenAnswers.length;i++)
  {
    summary.add({
      'question_index':i,
      'question':questions[i].text,
      'correct_answer':questions[i].answers[0],
      'user_answer':chosenAnswers[i]
    });
  }
  return summary;
}
@override
Widget build(BuildContext context)
{
  final summaryData=getSummaryData();
  final numTotalQuestions=questions.length;
  final numCorrectQuestions=summaryData.where((data)
  {
    return data['user_answer']==data['correct_anser'];
  }).length;
  return SizedBox(
    width:double.infinity,
    child:Container(
      margin:const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text('Tou answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
          textAlign: TextAlign.center,),
          const SizedBox(height:30),
          QuestionsSummary(summaryData),

          const Text('List of answers and questions...'),
          const SizedBox(height:30),
          TextButton.icon(onPressed:onRestart,
          style:TextButton.styleFrom(foregroundColor:Colors.white),
          icon:const Icon(Icons.refresh),
          label:const Text('Restart Quiz')),
    
        ],
      ),
    ),
  );
}
}