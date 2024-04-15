import 'package:flutter/material.dart';
import 'package:intro/data/question_data.dart';
import 'package:intro/widgets/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

// AppBar
// Flutter'da sayfalar arası geçiş yöntemleri ve birbirlerine göre avantaj/dezavantajları ve kullanım oranları. (MEDIUM)
class _QuestionsScreenState extends State<QuestionsScreen> {
  // Dosyadan veri çek
  // Soruları tek tek ekranda göster.
  int currentQuestionIndex = 0; // O an kaçıncı soruda olduğumuz.
  bool resultPage = true;
  List ogrencicevap = List.filled(questions.length, [99, 99]);
  List cevapAnahtari = [
    [0, 0],
    [1, 1],
    [2, 2],
    [3, 0],
    [4, 6]
  ];
  List dogruCevap = [];
  List yanliscevap = [];
  void answer() {
    // Cevap verildiğinde verilen cevapları hafızada tut.
    // Sonuç ekranını tasarlayınız.
    setState(() {
      if (currentQuestionIndex < questions.length - 1)
        currentQuestionIndex++;
      else
        resultPage = false;
    });
  }

  void kontrol(List test, List cevap) {
    for (int i = 0; i < test.length; i++) {
      if (test[i][1] == cevap[i][1]) {
        dogruCevap.add(test[i]);
      } else {
        yanliscevap.add(test[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final numberOfAnswers = questions[currentQuestionIndex]
        .answers
        .length; //Sorunun kaç cevabı var?

    List<Widget> answerButtons = [];
    for (int i = 0; i < numberOfAnswers; i++) {
      answerButtons.add(
        AnswerButton(
          answerText: currentQuestion.answers[i],
          onClick: () {
            // print(currentQuestion.answers[i]);
            // ogrencicevap.add([currentQuestionIndex, i]);
            ogrencicevap[currentQuestionIndex] = [currentQuestionIndex, i];
            answer();
          },
        ),
      );
    }

    return Scaffold(
      body: resultPage
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      currentQuestion.question,
                      style: const TextStyle(fontSize: 18),
                    ),
                    ...answerButtons,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (currentQuestionIndex > 0)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentQuestionIndex--;
                              });
                            },
                            child: const Text("Geri"),
                          ),
                        if (currentQuestionIndex < questions.length - 1)
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  currentQuestionIndex++;
                                });
                              },
                              child: const Text("İleri")),
                        if (currentQuestionIndex == questions.length - 1)
                          ElevatedButton(
                              onPressed: () {
                                kontrol(cevapAnahtari, ogrencicevap);
                                setState(() {
                                  resultPage = false;
                                });
                              },
                              child: const Text("Sonuc Ekranı"))
                      ],
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child:
                              Text("doğru cevap sayısı:${dogruCevap.length}"),
                        )),
                    Text("Yanlış Cevap Sayısı ${yanliscevap.length}")
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // print(ogrencicevap);
        // kontrol(cevapAnahtari, ogrencicevap);
        // print(dogruCevap);
        // print(yanliscevap);
      }),
    );
  }
}
// Snippet