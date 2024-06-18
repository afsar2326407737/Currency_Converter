import 'dart:async';

import 'package:currency_converter/models/allcurrencies.dart';
import 'package:currency_converter/models/ratesmodel.dart';
import 'package:flutter/material.dart';
import '../components/anyToAny.dart';
import '../components/usdToAny.dart';
import '../functions/fetchrates.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState(){
    result = fetchrates();
    allcurrencies = fetchcurrencis();
  }

  // initial variables

  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();



  @override
  void initstate(){
    super.initState();
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencis();
    });
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Currency Converter",
        style: TextStyle(
          fontSize: 30,
          color: Colors.white,
        ),
        ),
      ),
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context,snapshot){
                if( snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                return Center(
                  child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context,currSnapshot){
                      if ( currSnapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          UsdToAny(
                            currencies:currSnapshot.data!,
                            rates:snapshot.data!.rates,
                          ),
                          AnyToAny(
                            currencies:currSnapshot.data!,
                            rates:snapshot.data!.rates,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),

    );
  }
}

