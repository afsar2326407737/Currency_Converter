import 'package:currency_converter/functions/fetchrates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AnyToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const AnyToAny(
  {Key ? key , @required this.rates , required this.currencies}
      )
  :super (key: key);

  @override
  _AnyToAnyState createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';
  String answer = ' Convert Currencies will be show here :)';


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Convert Any Currencies ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            SizedBox(height: 20,),


            // Text Fied for entering the usd
            TextFormField(
              key:ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(hintText: "Enter the Amount"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded:true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue1=newValue!;
                        });
                      },
                      items: widget.currencies.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value){
                          return DropdownMenuItem<String>(
                            value: value,
                              child: Text(value)
                          );
                      }).toList(),
                    ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To'),),
                Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.grey.shade400,
                      ),
                      onChanged: (String? newValue){
                        setState(() {
                          dropdownValue2=newValue!;
                        });
                      },
                      items: widget.currencies.keys
                          .toSet()
                          .toList()
                          .map<DropdownMenuItem<String>>((value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                            );

                      }).toList(),
                    ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    answer=amountController.text+
                    ' '+
                    convertany(widget.rates, amountController.text, dropdownValue1,dropdownValue2)+
                    ' '+
                    dropdownValue2;
                  });
                },
                child: Text('Convert',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                )
              ),
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(height: 10,),
            Container(child: Text(answer ,
            style: TextStyle(
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
