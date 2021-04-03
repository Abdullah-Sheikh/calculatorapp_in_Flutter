import 'package:flutter/material.dart';

void main()=> runApp(new MyApp());

bool  _ligth =true;

class MyApp extends StatelessWidget
{





  Widget build (BuildContext buildcx) {
    return new MaterialApp(
      title: '',
      home: new IosCal(),

    );
  }

  @override
  State<StatefulWidget> createState() {

  }


}

class IosCal extends StatefulWidget{
  IosCalState createState()=> IosCalState();
}

class IosCalState extends State<IosCal> {

  dynamic texts ='0';
  double numOne = 0;
  double numTwo= 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  ThemeData darktheme = ThemeData(
      brightness: Brightness.dark,
  );
  ThemeData ligththeme = ThemeData(
      brightness: Brightness.light,
  );

  @override
  Widget build(BuildContext buildcx) {
    return new MaterialApp(
    theme: _ligth ? ligththeme : darktheme,
   home: Scaffold(
      appBar: null,

     // backgroundColor: Colors.black,

      body: new Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

       Row(
         children: <Widget>[
           Switch(value: _ligth, onChanged: (state)
           {
    setState(() {
      _ligth = state;
       });
           })
         ],
       ),
          Row(
            children: <Widget>[
              Expanded(child:
             Padding(
             padding: EdgeInsets.only(right: 20.0),
                child: Text(
                  texts,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 60.0,
                  ),
                  textAlign: TextAlign.right,
                ))),
          ],),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            btn('C', const Color(0xffa5a5a5)),
            btn('+/-', const Color(0xffa5a5a5)),
            btn('%', const Color(0xffa5a5a5)),
            btn('/',  Colors.orange),
          ],)
          , Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            btn('7', const Color(0xff333333)),
            btn('8', const Color(0xff333333)),
            btn('9', const Color(0xff333333)),
            btn('x',  Colors.orange),
          ],)
          , Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            btn('4', const Color(0xff333333)),
            btn('5', const Color(0xff333333)),
            btn('6', const Color(0xff333333)),
            btn('+',  Colors.orange),
          ],)
          , Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
            btn('1', const Color(0xff333333)),
            btn('2', const Color(0xff333333)),
            btn('3', const Color(0xff333333)),
            btn('-',  Colors.orange),
          ],)
          , Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              btnzero('0', const Color(0xff333333)),
              btn('.', const Color(0xff333333)),
              btn('=',  Colors.orange),
            ],)
       ],

      ),
    ));
  }

  Widget btn(value, Color color) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: new RaisedButton(
        child: Text(value,
        style: TextStyle(fontSize: 30,color: Colors.white)),
        onPressed: () {calculation(value);},
        color: color,
        padding: EdgeInsets.all(20.0),
        shape: CircleBorder(),
      ),
    );

  }

  Widget btnzero(value, Color color) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: new RaisedButton(
        child: Text(value,
            style: TextStyle(fontSize: 30,color: Colors.white)),
        onPressed: () {calculation(value);},
        color: color,
        padding: EdgeInsets.only(left: 25,top: 20,bottom: 20,right: 115),
        shape: StadiumBorder(),
      ),
    );
  }

  void calculation(btnText) {


    if(btnText  == 'C') {
      texts ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      texts = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }



}

