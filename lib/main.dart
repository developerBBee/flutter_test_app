import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calculator/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formatter = NumberFormat("#,###.#");
  final calc = Calculator();
  num resultNumber = 0;
  var resultString = '0';
  var buffer = '';
  var operator = '';
  String? x1 = null;
  String? x2 = null;

  void _onPressed(String str) {
    setState(() {
      resultString = calc.calculateEvent(str);
    });
  }

  @override
  Widget build(BuildContext context) {
    final contentSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    var maxHeight = contentSize.height - padding.top - padding.bottom;
    // アプリ描画エリアの縦サイズを取得
    if (Platform.isAndroid) {
      maxHeight = contentSize.height - padding.top - kToolbarHeight;
    } else if (Platform.isIOS) {
      maxHeight = contentSize.height - padding.top - padding.bottom - 22;
    }
    var resultHeight = maxHeight * 3.0/10.0;
    var calculatorHeight = maxHeight - resultHeight;

    final buttonStyle = ButtonStyle(
      elevation: MaterialStateProperty.all(0.2),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(Colors.white10),
      padding: MaterialStateProperty.all(const EdgeInsets.only(top: 20, bottom: 20)),
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
        return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15));
      }),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            width: contentSize.width,
            height: resultHeight,
            alignment: Alignment.center,
            child: Material(
              elevation: 1,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           Text(resultString, style: const TextStyle(fontSize: 40),)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: const [
                          //Text('+-*/', style: TextStyle(fontSize: 40),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: contentSize.width,
            height: calculatorHeight,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('C'), child: const Text('Ｃ'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('CE'), child: const Text('ＣＥ'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('del'), child: const Text('→'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('div'), child: const Text('／'),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('7'), child: const Text('７'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('8'), child: const Text('８'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('9'), child: const Text('９'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('mul'), child: const Text('＊'),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('4'), child: const Text('４'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('5'), child: const Text('５'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('6'), child: const Text('６'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('min'), child: const Text('－'),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('1'), child: const Text('１'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('2'), child: const Text('２'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('3'), child: const Text('３'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('plu'), child: const Text('＋'),),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('0'), child: const Text('０'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('00'), child: const Text('００'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('.'), child: const Text('．'),),
                    TextButton(
                      style: buttonStyle,
                      onPressed: ()=>_onPressed('equ'), child: const Text('＝'),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
