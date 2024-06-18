import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../functions/fetchrates.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({Key? key,@required this.rates , required this.currencies});

  @override
  _UsdToAnyState createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = 'Convert Currencies will be shown here :)';
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("USD To ANY Currencies",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              key:ValueKey('usd'),
              controller: usdController,
              decoration: InputDecoration(
                hintText: "Enter Usd"
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 20,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,

                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue=newValue!;
                        });
                      },
                      items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value){
                          return DropdownMenuItem <String>(
                              value: value,
                              child: Text(value)
                          );
                      }).toList(),
                    )
                ),
                SizedBox(width: 20,),
                Container(
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        answer=usdController.text+
                            'USD ='+
                            convertusd(widget.rates,usdController.text,
                            dropdownValue)+' '+dropdownValue;
                      });
                    },
                    child: Text('Converted',style: TextStyle(
                      fontSize: 19,
                      color: Colors.white
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
            //Final Out Put
            SizedBox(height: 10,),
            Container(child: Text(answer,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black
            ),
            ),
            )
          ],
        ),
      ),
    );
  }
}
