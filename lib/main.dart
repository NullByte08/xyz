import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String enteredText = "";

  List<String> splitText(String inputText) {
    String eText = inputText; // not making changes to the input directly.
    List<String> list = [];
    int splittingIndex = 49;
    while (eText.length > 50) {
      splittingIndex = 49; // on every iteration of splitting the eText, splittingIndex will be reset to 49
      if (eText[splittingIndex] == " ") {  // if char at splitting index is a white space, simply split the text into two parts. And eText will be assigned to the second part, to run the loop on it again and check if the second part is <50.
        list.add(eText.substring(0, splittingIndex + 1));
        eText = eText.substring(splittingIndex + 1, eText.length);
      } else {
        //if char at splitting index is any other character than a white space. Reduce the splitting index by 1 till char at splitting index is a white space.
        while (eText[splittingIndex] != " " && splittingIndex > 0) { // also splittingIndex should be > 0 otherwise it will imply that it is a complete word of more than 50 letters and cant be broken down.
          splittingIndex--;
        }
        list.add(eText.substring(0, splittingIndex + 1));
        eText = eText.substring(splittingIndex + 1, eText.length);
      }
    }

    if(eText.length<=50) {
      list.add(eText);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  enteredText = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Text("${index+1}/${splitText(enteredText).length} ${splitText(enteredText)[index]}");
                },
                itemCount: splitText(enteredText).length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
