import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.grey,
  primary: Colors.green,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controladorPeso = TextEditingController();
  TextEditingController controladorAltura = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!!";

  void _resetFields(){
    setState(() {
      _infoText = "Informe seus dados!!";
    });
    controladorPeso.text = "";
    controladorAltura.text = "";
  }

  void _calculo(){
   setState(() {
     double peso = double.parse(controladorPeso.text);
     double altura = double.parse(controladorAltura.text)/ 100;
     double imc = peso / (altura * altura);
     if(imc < 18.6){
       _infoText = "Abaixo do peso!!!! (${imc.toStringAsPrecision(3)})";
     }
     else if(imc >= 18.6 && imc <24.9){
       _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
     }
     else if(imc >= 24.9 && imc <29.9){
       _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
     }
     else if(imc >= 29.9 && imc <34.9){
       _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
     }
     else if(imc >= 34.9 && imc <= 39.9){
       _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
     }
     else{
       _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
     }

   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(onPressed: _resetFields, icon: Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (Kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.5,
                ),
                controller: controladorPeso,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira o peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (Cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.5,
                ),
                controller: controladorAltura,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Insira a sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 20.0,
                ),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        _calculo();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    style: raisedButtonStyle,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
