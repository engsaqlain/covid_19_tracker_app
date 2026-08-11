import 'package:covid_19_tracker_app/view/world_states_screen.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

   DetailScreen(
  {
    required this.name,
  required this.image,
  required this.totalCases,
  required this.totalDeaths,
  required this.totalRecovered,
  required this.active,
  required this.critical,
  required this.todayRecovered,
  required this.test,});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.057),
              child:  Card(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                   ReusableRow(title: 'Total Cases', value: widget.totalCases),
                    ReusableRow(title: 'Total Deaths', value: widget.totalDeaths),
                    ReusableRow(title: 'Total Recovered', value: widget.totalRecovered),
                    ReusableRow(title: 'Active', value: widget.active),
                    ReusableRow(title: 'Critical', value: widget.critical),
                    ReusableRow(title: 'Today Recovered', value: widget.todayRecovered),
                    ReusableRow(title: 'Tests', value: widget.test),
                    ]
              ),
            ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.image),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06,),

    ]
    )
    );
  }
}
