import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show  Platform;
import 'package:currency_convertor/Api/apiService.dart';
import 'package:loading_overlay/loading_overlay.dart';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}
class _PriceScreenState extends State<PriceScreen> {
  String Connection;
  bool _isloading=false;
  CryptoPrice cryptoprice=new CryptoPrice();
  var data;
  double price=0;
  String SelectedCurrency="INR";
  //for platform specific drop down button
  DropdownButton<String> AndroidDropDownButton(){
    List<DropdownMenuItem<String>> dropdownItems=[];
    for(int i=0;i<currenciesList.length;i++){
      String currency= currenciesList[i];
      var newItem=DropdownMenuItem(child: Text(currency),value: currency,);
      dropdownItems.add(newItem);
    }

  return  DropdownButton<String>(
  value: SelectedCurrency,items: dropdownItems,onChanged: (value){


  setState(() {

  SelectedCurrency=value;

    setPrice();


});
},);

  }

  //for ios
  CupertinoPicker IOSpicker(){
    List<Text> pickerItem=[];
    for(String currency in currenciesList){
      var newItem=Text(currency);
      pickerItem.add(newItem);
    }

   return CupertinoPicker(itemExtent: 32.0,onSelectedItemChanged: (selectedIndex){
    setState(() {
      SelectedCurrency=pickerItem[selectedIndex].toString().split('Text("')[1].split('"')[0];
      setPrice();
    });


    },children: pickerItem

    );
  }
  //for picking up picker
  Widget getPicker(){
    if(Platform.isIOS){
      return IOSpicker();
    }
    else if(Platform.isAndroid){
      return AndroidDropDownButton();
    }
  }
  //for updating data
  void setPrice()async{
    setState(() {
      _isloading=true;
    });
    data=await cryptoprice.getBitcoinPrice(SelectedCurrency);
    setState(() {
      if(data!=[] && data!=null){
        price=double.parse(data[0]["rate"].toStringAsFixed(2));
        
        _isloading=false;
      }
    });

  }
  //for internet Connection





  @override
  initState() {
    // TODO: implement initState
   setState(() {
     setPrice();
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("🔰Coin Ticker")),
        ),
        body: LoadingOverlay(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
                 child: Center(
                   child: Text(
                     data!=[] && data !=null && data.length>0?
                     '1 BTC =${double.parse(data[0]["rate"].toStringAsFixed(2))} $SelectedCurrency':'1 BTC =0.0 $SelectedCurrency'
                   ),
                 ), ),
                ),),
              ),
              Expanded(
                child: Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
                      child: Center(
                        child: Text(
                            data!=[] && data !=null && data[1]!=null && data.length>1?
                            '1 ETH =${double.parse(data[1]["rate"].toStringAsFixed(2))} $SelectedCurrency':'1 ETH =0.0 $SelectedCurrency'
                        ),
                      ), ),
                  ),),
              ),
              Expanded(
                child: Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
                      child: Center(
                        child: Text(
                            data!=[] && data !=null && data.length>2?
                            '1 LTC =${double.parse(data[2]["rate"].toStringAsFixed(2))} $SelectedCurrency':'1 LTC =0.0 $SelectedCurrency'
                        ),
                      ), ),
                  ),),
              ),
              Expanded(
                child: Padding(padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
                      child: Center(
                        child: Text(
                            data!=[] && data !=null && data.length>3?
                            '1 DOGE =${double.parse(data[3]["rate"].toStringAsFixed(2))} $SelectedCurrency':'1 DOGE =0.0 $SelectedCurrency'
                        ),
                      ), ),
                  ),),
              ),
              SizedBox(
                height: 100,
              ),

              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: getPicker()
              )
            ],
          ),
          isLoading: _isloading,
            opacity: 0.5,
            progressIndicator: CircularProgressIndicator()
         )
    )    ;
  }





  }

