import 'dart:ui';

import 'package:covid_19_tracker_app/Services/state_services.dart';
import 'package:covid_19_tracker_app/model/WordlStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'country_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  StateServices stateServices = StateServices();
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Covid-19'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Expanded(
                child: FutureBuilder(
                  future: stateServices.fetchWorldStatesRecord(),
                  builder: (context, AsyncSnapshot<WordlStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(
                                  snapshot.data!.cases.toString(),
                                ),
                                'Recovered': double.parse(
                                  snapshot.data!.recovered.toString(),
                                ),
                                'Deaths': double.parse(
                                  snapshot.data!.deaths.toString(),
                                ),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 2.8,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.05,
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases,
                                    ),
                                    ReusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered,
                                    ),
                                    ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths,
                                    ),
                                    ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active,
                                    ),
                                    ReusableRow(
                                      title: "Critical",
                                      value: snapshot.data!.critical,
                                    ),
                                    ReusableRow(
                                      title: "Today Cases",
                                      value: snapshot.data!.todayCases,
                                    ),
                                    ReusableRow(
                                      title: "Today Deaths",
                                      value: snapshot.data!.todayDeaths,
                                    ),
                                    ReusableRow(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CountryList(),));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Track Countries",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final dynamic value;
  const ReusableRow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value.toString())],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
