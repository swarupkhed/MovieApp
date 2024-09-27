import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:movie_app/main.dart';
import 'package:movie_app/screens/HomeScreen.dart';

import '../GlobalVariable.dart';


class DetailsScreen extends StatefulWidget{
    DetailsScreen({super.key, required this.id});

      int id;
   @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

     String url = "https://i.pinimg.com/736x/ea/8d/11/ea8d11f1ffc6355b8a440106ce61d0f3.jpg";
     String laguage="NA";
     double rating=0;
     String country="NA";
     if ( data[widget.id]['show']['image'] != null) {
      url =  data[widget.id]['show']['image']['original'];
    }
     if ( data[widget.id]['show']['language'] != null) {
       laguage =  data[widget.id]['show']['language'] ;
     }
     if ( data[widget.id]['show']['rating']['average'] != null) {
       rating =  data[widget.id]['show']['rating']['average'] +0.0;
     }
     if ( data[widget.id]['show']['network'] != null) {
       country =  data[widget.id]['show']['network']['country']['name'];
     }

     return  Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(222, 36, 36, 62),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,size: 40,),
          color:const Color.fromARGB(222, 104, 213, 225),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Movie App',)),
            );
          },
        ),
      ) ,
      body:

       Container(
         width: double.infinity,
         decoration: const BoxDecoration(
          color: Color.fromARGB(165, 5, 34, 69),
        ),
        child:ListView(
          children: [
            Column(
              children: [
                ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 0,
                      maxWidth: 700,
                      minHeight: 410,
                      maxHeight: 800,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Image.network(url,fit: BoxFit.cover,),
                    )
                ),
                Text(data[widget.id]['show']['name'],style: TextStyle(fontSize: 40,color: Colors.white),)
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),

              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.end ,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Language : $laguage ',style: const TextStyle(fontSize: 24,color: Colors.white),),
                    Text('Rating :  $rating ',style: const TextStyle(fontSize: 24,color: Colors.white),),
                    Text('Country : $country ',style: const TextStyle(fontSize: 24,color: Colors.white),),
                     HtmlWidget(
                      data[widget.id]['show']['summary'],
                      textStyle: TextStyle(
                        fontSize: 20,
                        letterSpacing: 1.5,
                        wordSpacing: 1,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),

            )

           ],
        )

      ),
    );
  }
}