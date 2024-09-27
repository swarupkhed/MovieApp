import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/screens/DetailsScreen.dart';

import 'package:google_fonts/google_fonts.dart';

import '../GlobalVariable.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future fetchData() async {
    final response =
    await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(

      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
              "data loading"); // Show a loading indicator while fetching data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Display the fetched data
          print(snapshot.data.length);
          print(snapshot.data);
          print('------------');
          print((snapshot.data[2]['show']['image']));
          print('-------------');
          data=snapshot.data;
          return ListView.builder(


            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              // Build custom widgets based on fetched data
              String url = "https://i.pinimg.com/736x/ea/8d/11/ea8d11f1ffc6355b8a440106ce61d0f3.jpg";
              if (snapshot.data[index]['show']['image'] != null) {
                url = snapshot.data[index]['show']['image']['original'];
              }
              return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),

                  child: Center(
                    child:
                    Stack(

                        children: [
                          // gesture detector to detect the image tab
                          GestureDetector(
                              child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Colors.black,
                                    BlendMode.dst,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.network(
                                      url, fit: BoxFit. cover,
                                    ),
                                  )

                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(id:index)));
                              },


                          ),
                          Positioned.fill(

                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Text(
                                    snapshot.data[index]['show']['name'],

                                    style: GoogleFonts.cinzel(
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )


                            ),
                          )


                        ]
                    ),

                  ),
              );
            },
          );
        }
      },
    );
  }
}

