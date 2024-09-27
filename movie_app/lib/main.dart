import 'package:flutter/material.dart';
import 'package:movie_app/screens/HomeScreen.dart';
import 'package:movie_app/screens/SearchScreen.dart';
import 'package:movie_app/screens/SplashScreen.dart';
import 'package:movie_app/GlobalVariable.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(222, 165, 143, 143)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Widget> body= [
     const HomeScreen(),
     const SearchScreen(),
    const Icon(Icons.face),
  ];

  @override
  Widget build(BuildContext context) {


     return Scaffold(
       extendBody: true,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Color.fromARGB(222, 36, 36, 62),
        automaticallyImplyLeading: false,
        // Here we take the value from the MyHomePage object tha t was created by
        // the App.build method, and use it to set our appbar title.
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );

              },
            ),
          ],
          title: Text(widget.title,style: GoogleFonts.marcellusSc(
          fontWeight: FontWeight.w600,
          fontSize: 30,
          color: Colors.white,
        ))

       ),

      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the pmiddle of the parent.
        decoration: const BoxDecoration(
          color: Color.fromARGB(222, 165, 143, 143),
        ),
        child: body[currentInd],
      ),
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: currentInd,
         onTap: (int newIndex){
           setState(() {
             currentInd=newIndex;
           });
         },
         items: const[
           BottomNavigationBarItem(
                label: ('Home') ,
               icon: Icon(Icons.home,size: 35),
           ),
           BottomNavigationBarItem(
               label: 'Search',
               icon: Icon(Icons.search,size: 35)
           ),
           BottomNavigationBarItem(
               label: 'Profile',
               icon: Icon(Icons.person,size: 35)
           )

         ],
         elevation: 0, // to get rid of the shadow
          selectedItemColor: const Color.fromARGB(255, 136, 234, 44),
          backgroundColor: const Color(0x00ffffff), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
         type: BottomNavigationBarType.fixed,
         unselectedItemColor: const Color.fromARGB(255, 241, 237, 237),
     ),

     );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  get search_term => null;

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return    [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = 'https://api.tvmaze.com/search/shows?q=$search_term';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
     return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {

        currentInd=0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Movie App',)),
        );
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (query.length < 3) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return const Text('dead');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text("suggestion");
  }
}