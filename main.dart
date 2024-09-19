import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
   @override
  MyAppState createState() => MyAppState();
}
 
class MyAppState extends State<MyApp> {
  var _resultMessage;

  var _startMeasure;

  dynamic _convertedMeasure;

  final List<String> _measures = [ 'meters',
  'kilometers', 'grams', 'kilograms', 'feet',
  'miles', 'pounds (lbs)', 'ounces',
  ];
  
  final Map<String, int> _measuresMap = { 'meters' : 0,
  'kilometers' : 1,
  'grams' : 2,
  'kilograms' : 3,
  'feet' : 4,
  'miles' : 5,
  'pounds (lbs)' : 6,
  'ounces' : 7,
    };

  // dynamic myValue = measures['miles'];

  final dynamic _formulas = { '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
  '1':[1000,1,0,0,3280.84,0.621371,0,0],
  '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
  '3':[0,0,1000,1,0,0,2.20462,35.274],
  '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
  '5':[1609.34, 1.60934,0,0,5280,1,0,0],
  '6':[0,0,453.592,0.453592,0,0,1,16],
  '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };
 
  double _numberFrom=0;

  @override
  void initState() {
  _numberFrom = 0; super.initState();
  }


  @override
  Widget build(BuildContext context){
    final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey[700],
    );
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
          ),
        body: Container( 
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
          child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Add UI elements here
          SizedBox(height: 20),
          Text(
          'Value',
          style: labelStyle,
          ), // Value Label
          TextField(
          style: inputStyle,
          decoration: InputDecoration(
          hintText: "Please insert the measure to be converted",
          ),
          onChanged: (text) {
          var rv = double.tryParse(text);
          if (rv != null) {
          setState(() {
          _numberFrom = rv;
          });
          }
          },
          ), Text((_numberFrom == null) ? '' : _numberFrom.toString()), // Text Field
          SizedBox(height: 10),
          SizedBox(height: 20),
          Text(
          'From',
          style: labelStyle,
          ), // From Label
          DropdownButton<String>(
          isExpanded: true,
          items: _measures.map((String value) {
          return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
          );
          }).toList(),
          onChanged: (value) {
          setState(() {
          _startMeasure = value;
          });
          },
          value: _startMeasure,
          ), // 'Convert From' Dropdown
          SizedBox(height: 20),
          Text(
          'To',
          style: labelStyle,
          ), // To Label
           DropdownButton<String>(
          isExpanded: true,
          style: inputStyle,
          items: _measures.map((String value) {
          return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: inputStyle),
          );
          }).toList(),
          onChanged: (value) {
          setState(() {
          _convertedMeasure = value;
          });
          },
          value: _convertedMeasure,
          ), // 'Convert To' Dropdown
          SizedBox(height: 40),
          ElevatedButton(
          child: Text('Convert', style: inputStyle), onPressed: () {
          if (_startMeasure.isEmpty || _convertedMeasure.isEmpty ||
          _numberFrom==0) {
          return;
          }
          else {
          convert(_numberFrom, _startMeasure, _convertedMeasure);
          }
          },
          ), // Convert Button
          SizedBox(height: 20),
          Text(
          (_numberFrom == null) ? '' : _numberFrom.toString(),
          style: labelStyle,
          textAlign: TextAlign.center,
          ), // Result Label
          Text((_resultMessage == null) ? '' : _resultMessage, style: labelStyle),
          ], // Children
          ),
          ),
          ),
          ), 
      ),
    );
  }

  void convert(double value, String from, String to) { int? nFrom = _measuresMap[from];
  int? nTo = _measuresMap[to];
  var multiplier = _formulas[nFrom.toString()][nTo]; /*might change this to double*/ var result = value * multiplier;

  if (result == 0) {
  _resultMessage = 'This conversion cannot be performed';
  }
  else {
  _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
  }
  setState(() {
  _resultMessage = _resultMessage;
  });

 }
}