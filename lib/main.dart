import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculadoraIphone(),
    );
  }
}

class CalculadoraIphone extends StatefulWidget {
  const CalculadoraIphone({super.key});

  @override
  State<CalculadoraIphone> createState() => _CalculadoraIphoneState();
}

class _CalculadoraIphoneState extends State<CalculadoraIphone> {
  dynamic displaytxt = 20;

  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: txtcolor, backgroundColor: btncolor, // Text color
        shape: const CircleBorder(), // Shape
        padding: const EdgeInsets.all(22), // Padding
      ), // Your onPressed logic here
      child: Text(
        '$btntxt',
        style: TextStyle(
          fontSize: 35,
          color: txtcolor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Calculadora',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 100),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: calcbutton('AC', Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('+/-', Colors.grey, Colors.black)),
                  Expanded(child: calcbutton('%', Colors.grey, Colors.black)),
                  Expanded(
                      child:
                          calcbutton('/', Colors.amber.shade700, Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child:
                          calcbutton('7', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('8', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('9', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('x', Colors.amber.shade700, Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child:
                          calcbutton('4', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('5', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('6', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child: calcbutton(
                          '-', Colors.amber.shade700, Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child:
                          calcbutton('1', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('2', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('3', Colors.grey.shade800, Colors.white)),
                  Expanded(
                      child:
                          calcbutton('+', Colors.amber.shade700, Colors.white)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.grey.shade800),
                    child: const Text(
                      "0",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                  calcbutton('.', Colors.grey.shade800, Colors.white),
                  calcbutton('=', Colors.grey.shade800, Colors.white),
                ],
              )
            ],
          ),
        ));
  }


// logica da calculadora
  dynamic text = '0';
  double numUm = 0;
  double numDois = 0;

  dynamic resultado = '';
  dynamic finalResultado = '';
  dynamic operacao = '';
  dynamic preOperacao = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numUm = 0;
      numDois = 0;
      resultado = '';
      finalResultado = '0';
      operacao = '';
      preOperacao = '';
    } else if (operacao == '=' && btnText == '=') {
      if (preOperacao == '+') {
        finalResultado = add();
      } else if (preOperacao == '-') {
        finalResultado = sub();
      } else if (preOperacao == 'x') {
        finalResultado = mul();
      } else if (preOperacao == '/') {
        finalResultado = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numUm == 0) {
        numUm = double.parse(resultado);
      } else {
        numDois = double.parse(resultado);
      }

      if (operacao == '+') {
        finalResultado = add();
      } else if (operacao == '-') {
        finalResultado = sub();
      } else if (operacao == 'x') {
        finalResultado = mul();
      } else if (operacao == '/') {
        finalResultado = div();
      }
      preOperacao = operacao;
      operacao = btnText;
      resultado = '';
    } else if (btnText == '%') {
      resultado = numUm / 100;
      finalResultado = doesContainDecimal(resultado);
    } else if (btnText == '.') {
      if (!resultado.toString().contains('.')) {
        resultado = resultado.toString() + '.';
      }
      finalResultado = resultado;
    } else if (btnText == '+/-') {
      resultado.toString().startsWith('-')
          ? resultado = resultado.toString().substring(1)
          : resultado = '-' + resultado.toString();
      finalResultado = resultado;
    } else {
      resultado = resultado + btnText;
      finalResultado = resultado;
    }

    setState(() {
      text = finalResultado;
    });
  }

  String add() {
    resultado = (numUm + numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String sub() {
    resultado = (numUm - numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String mul() {
    resultado = (numUm * numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String div() {
    resultado = (numUm / numDois).toString();
    numUm = double.parse(resultado);
    return doesContainDecimal(resultado);
  }

  String doesContainDecimal(dynamic resultado) {
    if (resultado.toString().contains('.')) {
      List<String> splitDecimal = resultado.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return resultado = splitDecimal[0].toString();
    }
    return resultado;
  }
}