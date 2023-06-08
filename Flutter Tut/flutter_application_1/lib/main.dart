import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
//Stateless widget are useful when the part of the user interface 
//you are describing does not depend on anything other than the configuration information 
//in the object itself and the [BuildContext] in which the widget is inflated

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 137, 224, 155)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

//everything that exists in memory when the app is running.
// This includes the app's assets, all the variables that the Flutter framework keeps about the UI, animation state, textures, fonts, and so on
//Tracks all changes made to  the above values ^ with ChangeNotifier
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      //you can refactor the column to center it by 'wrapping with center'
      body: Center(
        child: Column(
          //centers the children on a vertical axis
          mainAxisAlignment: MainAxisAlignment.center,
          //children in the HomePage are declarations for your widget
          children: [
            BigCard(pair: pair),
            SizedBox(height: 10),
            ElevatedButton(onPressed: ()
            {appState.getNext();},
             child: Text('Next'),
             ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

//Widget build  method always returns a widget
  @override
  Widget build(BuildContext context) {
    final  theme = Theme.of(context);
  //theme.textTheme accesses  the app's font theme
  //The displayMedium property is a large style meant for display text
  //display styles are reserved for short, important text
  //Calling copyWith() on displayMedium returns a copy of the text style with the changes you define
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.surface,
      fontStyle: FontStyle.italic,
    );
//Wrapping with a widget Card  means Card Widget contains Padding widget and Text 
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          pair.asLowerCase, 
          style:style,
          semanticsLabel : "${pair.first} ${pair.second}",
          ),
      ),
    );    
  }
}