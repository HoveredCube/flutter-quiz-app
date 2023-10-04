import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';


class RadioButtonProvider extends ChangeNotifier{


  int _selectedOption = 4;
  // List<String> _optionsList= ['the','what?', 'sheesh', 'mamad'];


  List<Color> containerNotSelectedStyle = [
    const Color(0xFF171717), // this is the Container color
    const Color(0xFF171717), // this is the border color
    const Color(0xFFD1D1D1), // this is the option title color
  ];

  List<Color> containerSelectedStyle = [
    const Color(0xFF222222), // this is the Container color
    const Color(0xFF4B4B4B), // this is the border color
    const Color(0xFFFFFFFF), // this is the option title color
  ];

  late List<Color> _containerStyle0 = containerNotSelectedStyle;
  late List<Color> _containerStyle1 = containerNotSelectedStyle;
  late List<Color> _containerStyle2 = containerNotSelectedStyle;
  late List<Color> _containerStyle3 = containerNotSelectedStyle;


  getContainerStyle(){
    return [
      _containerStyle0,
      _containerStyle1,
      _containerStyle2,
      _containerStyle3,
    ];
  }

  changeContainerStyle(int optionContainerNumber){
    if (optionContainerNumber == 0){
      _containerStyle0 = containerSelectedStyle;
      _containerStyle1= containerNotSelectedStyle;
      _containerStyle2 = containerNotSelectedStyle;
      _containerStyle3 = containerNotSelectedStyle;
    }
    if (optionContainerNumber == 1){
      _containerStyle0 = containerNotSelectedStyle;
      _containerStyle1= containerSelectedStyle;
      _containerStyle2 = containerNotSelectedStyle;
      _containerStyle3 = containerNotSelectedStyle;
    }
    if (optionContainerNumber == 2){
      _containerStyle0 = containerNotSelectedStyle;
      _containerStyle1= containerNotSelectedStyle;
      _containerStyle2 = containerSelectedStyle;
      _containerStyle3 = containerNotSelectedStyle;
    }
    if (optionContainerNumber == 3){
      _containerStyle0 = containerNotSelectedStyle;
      _containerStyle1= containerNotSelectedStyle;
      _containerStyle2 = containerNotSelectedStyle;
      _containerStyle3 = containerSelectedStyle;
    }
    notifyListeners();
  }


  changeSelectedValueTo(theValue){
    if(theValue !=_selectedOption){
      _selectedOption = theValue;
      notifyListeners();
    }
  }

  selectedValue(){
    return _selectedOption;
  }
}