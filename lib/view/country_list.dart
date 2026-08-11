import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/state_services.dart';
import '../model/WordlStatesModel.dart';
import 'detail_screen.dart';
class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController();
  StateServices countryServices = StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Covid-19'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: countryServices.fetchCountryRecord(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                ListTile(
                                title: Container( height: 10, width: 89, color: Colors.white, ),
                            subtitle: Container( height: 10, width: 89, color: Colors.white, ),
                            leading: Container( height: 50, width: 50, color: Colors.white, ),
                            )
                                  ],
                                ),
                                );
                          }
                      );
                    }else{
                      return ListView.builder(

                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if(searchController.text.isEmpty){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                ),));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                    height: 50,
                                    width: 50,
                                    snapshot.data![index]['countryInfo']['flag']),
                              ),
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  test: snapshot.data![index]['tests'],
                                ),));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country'].toString()),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image.network(
                                    height: 50,
                                    width: 50,
                                    snapshot.data![index]['countryInfo']['flag']),
                              ),
                            );
                          }else{
                           return Container();
                          }

                        }
                    );
                    }
                  },
              )
              ),
            ],
          ),
        ),
      ),

    );
  }
}
