import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: completar todo lo necesario
  int? currentRadio;
  bool isSwitched = false;
  double tip = 0.0;
  TextEditingController service = TextEditingController();

  var radioGroup = {
    0: "Amazing (20%)", //esto es una entry key:value
    1: "Good (18%)",
    2: "Okay (15%)",
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service, color: Colors.green),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextFormField(
                controller: service,
                keyboardType: TextInputType.datetime,
                decoration: 
                InputDecoration(
                  label: Text("Cost of service"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining, color: Colors.green),
            title: Text("How was the service?"),
          ),
          //Text("Aqui agregar el GRUPO de radio buttons"),
          Column(
            children: radioGroupGenerator(),
          ),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.green),
            title: Text("Round up tip"),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                isSwitched = value;
                });
              },
            ),
          ),
          MaterialButton(
            child: Text("CALCULATE"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: (){
              _tipCalculation();
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Tip amount:  ${tip}", textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    double? service_2  = double.tryParse(service.text);
    if(service_2 == null){
      return;
    }
    
    if(currentRadio == 0){
      tip = service_2 * 0.20;
    }else if(currentRadio == 1){
      tip = service_2 * 0.18;
    }else if(currentRadio == 2){
      tip = service_2 * 0.15;
    }

    if (isSwitched) {
      tip = tip.ceilToDouble();
    }
    
  }
  

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
              value: radioElement.key, 
              groupValue: currentRadio, 
              onChanged: (int? newValue){
                currentRadio = newValue;
                setState(() {});
              }),
            title: Text("${radioElement.value}"),
          ),
        )
        .toList();
  }
}