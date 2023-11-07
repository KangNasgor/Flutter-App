import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

void main(){
  runApp(MaterialApp(home : MainMenu(),));
}

class MainMenu extends StatefulWidget{
  const MainMenu({super.key});

  _MainMenuState createState() => _MainMenuState();
}
int? date, month, year;
class _MainMenuState extends State<MainMenu>{

  String text = '';
  bool expandable = true;
  String? selectedItem = '1';
  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(value: '1', child: Text('Male')),
    DropdownMenuItem(value: '2', child: Text('Female')),
  ];
  String name = '';
  String gender = '';
  String birthday = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  void initState() {
    super.initState();

    birthdayController.addListener(() {
      String newBirthday = birthdayController.text;
      setState(() {
        birthday = newBirthday;
      });
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
          body : Container(
            height: expandable ? 125 : 500,
            width: 360,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF0E191F),
          ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                    child : Row(
                      children: [
                        Text(
                          'About',
                          style: TextStyle(
                            color : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 190,),
                        GestureDetector(
                          onTap: () {
                              setState(() {
                                expandable = false;
                              });
                            },
                          child: Visibility(
                            visible: expandable,
                              child: Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                              ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expandable = true;
                              name = nameController.text;
                              gender = selectedItem ?? '';
                              birthday = birthdayController.text;
                              log(getZodiac(birthday));
                            });
                          },
                          child: Visibility(
                            visible: !expandable,
                              child: Text(
                                'Save & Update',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
              ),

              Visibility(
                visible: expandable,
                child: Text(
                  'Add in your to help others know you better',
                  style: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
                Visibility(
                  visible: !expandable,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                         Row(
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color : Colors.white12,
                               ),
                               child: SizedBox(
                                 width: 60,
                                 height : 60,
                                 child: IconButton(
                                   onPressed: () {},
                                   icon: Icon(
                                     Icons.add,
                                     color: Colors.white,
                                     size: 30,
                                   ),
                                 ),
                               ),
                             ),
                             SizedBox(width: 15,),
                             Text(
                               'Add image',
                               style: TextStyle(
                                 color: Colors.white,
                               ),
                             ),
                           ],
                         ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Display name :',
                                style: TextStyle(
                                  color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 34,),
                              Container(
                                width: 200,
                                height: 30,
                                child: TextField(
                                    style: TextStyle(
                                        color: Colors.white54
                                    ),
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 130),
                                    labelText: 'Enter name',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 13,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      borderSide: BorderSide(
                                        color: Colors.white38,
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Gender :',
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 67,),
                              Container(
                                width: 200,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white12 ,
                                  border: Border.all(
                                    color: Colors.white38,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                  child: DropdownButtonFormField(
                                    value : selectedItem,
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 13,
                                    ),
                                    iconSize: 0,
                                    dropdownColor: Colors.black,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                        bottom: 17,
                                        left : 113,
                                      ),
                                      hintText: 'Select gender',
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white,),
                                    ),
                                    items: items,
                                    onChanged: (newValue) {
                                      setState(() => selectedItem = newValue);
                                    },
                                  ),
                                )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Birthday :',
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 62),
                              Container(
                                width: 200,
                                height: 30,
                                child: TextField(
                                  controller: birthdayController,
                                  style: TextStyle(
                                      color: Colors.white54
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(8),
                                    _BirthdayInputFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 120),
                                    labelText: 'DD MM YYYY',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 13,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.white38,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Horoscope :',
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 48,),
                              Container(
                                width: 200,
                                height: 30,
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.white54
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: getHoroscope(birthday),
                                    hintStyle: TextStyle(
                                      color: Colors.white38,
                                    ),
                                    contentPadding: EdgeInsets.only(
                                      left: 100,
                                      bottom : 15,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.white38,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Zodiac :',
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 62),
                              Container(
                                width: 200,
                                height: 30,
                                child: TextField(
                                  readOnly: true,
                                  style: TextStyle(
                                      color: Colors.white54
                                  ),
                                  decoration: InputDecoration(
                                    hintText: getZodiac(birthday),
                                    hintStyle: TextStyle(
                                      color: Colors.white38,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 150),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.white38,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                'Height :',
                                style: TextStyle(
                                    color: Colors.white54
                                ),
                              ),
                              SizedBox(width: 62),
                              Container(
                                width: 200,
                                height: 30,
                                child: TextField(
                                  style: TextStyle(
                                      color: Colors.white54
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 120),
                                    labelText: 'Add height',
                                    labelStyle: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 13,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                          color: Colors.white38,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                )
              ],
            ),
          ),
    );

  }
}

class _BirthdayInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,TextEditingValue newValue) {
    final text = newValue.text;
    var newText = '';
    if (text.length >= 2) {
      newText += text.substring(0, 2) + ' ';
    } else {
      newText += text.substring(0, text.length);
    }
    if (text.length >= 4) {
      newText += text.substring(2, 4) + ' ';
    } else if (text.length >= 2) {
      newText += text.substring(2, text.length);
    }
    if (text.length >= 8) {
      newText += text.substring(4, 8);
    } else if (text.length >= 4) {
      newText += text.substring(4, text.length);
    }
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
String getHoroscope(String birthday) {
  String dateStr = '';
  String? monthStr = '';
  if(birthday.length >= 10){
    dateStr = birthday.substring(0, 2);
    monthStr = birthday.substring(3, 5);
  }

  try{
    date = int.tryParse(dateStr);
    month = int.tryParse(monthStr);
  }
  catch (e){
    log('Invalid date or month');
  }
  final horoscopeDates = {
    'Aries': [DateTime(0, 3, 21), DateTime(0, 4, 19)],
    'Taurus': [DateTime(0, 4, 20), DateTime(0, 5, 20)],
    'Gemini': [DateTime(0, 5, 21), DateTime(0, 6, 20)],
    'Cancer': [DateTime(0, 6, 22), DateTime(0, 7, 22)],
    'Leo': [DateTime(0, 7, 23), DateTime(0, 8, 22)],
    'Virgo': [DateTime(0, 8, 23), DateTime(0, 9, 22)],
    'Libra': [DateTime(0, 9, 23), DateTime(0, 10, 23)],
    'Scorpius': [DateTime(0, 10, 24), DateTime(0, 11, 21)],
    'Sagitarius': [DateTime(0, 11, 22), DateTime(0, 12, 21)],
    'Capricorns': [DateTime(0, 12, 22), DateTime(0, 1, 19)],
    'Aquarius': [DateTime(0, 1, 20), DateTime(0, 2, 18)],
    'Pisces': [DateTime(0, 2, 19), DateTime(0, 3, 20)],
  };
  final inputDate = DateTime(0, month ?? 0, date ?? 0);
  for (final entry in horoscopeDates.entries) {
    String horoscope = entry.key;
    final dateRange = entry.value.map((date) => DateTime(0, date.month, date.day)).toList();
    if((month ?? 0) > 12){
      return horoscope = 'Invalid month';
    }
    else if((date ?? 0) > 31){
      return horoscope = 'Invalid date';
    }
    else if (inputDate.isAfter(dateRange[0]) && inputDate.isBefore(dateRange[1])) {
      log(horoscope);
      return horoscope;
    }
  }
  return 'Unknown';
}
String getZodiac(String birthday) {
  String dateStr = '';
  String? monthStr = '';
  String? yearStr = '';
  if (birthday.length >= 10) {
    dateStr = birthday.substring(0, 2);
    monthStr = birthday.substring(3, 5);
    yearStr = birthday.substring(6, 10);
  }
  try {
    date = int.tryParse(dateStr);
    month = int.tryParse(monthStr);
    year = int.tryParse(yearStr);
  }
  catch (e) {
    log('Invalid date/month/year');
  }
  final zodiacDates = {
    'Rabbit': [DateTime(2023, 1, 22), DateTime(2024, 2, 9)],
    'Tiger': [DateTime(2022, 2, 1), DateTime(2023, 1, 21)],
    'Ox': [DateTime(2021, 2, 12), DateTime(2022, 1, 31)],
    'Rat': [DateTime(2020, 1, 25), DateTime(2021, 2, 11)],
    'Pig': [DateTime(2019, 2, 5), DateTime(2020, 1, 24)],
    'Dog': [DateTime(2018, 2, 16), DateTime(2019, 2, 4)],
    'Rooster': [DateTime(2017, 1, 28), DateTime(2018, 2, 15)],
    'Monkey': [DateTime(2016, 2, 8), DateTime(2017, 1, 27)],
    'Goat': [DateTime(2015, 2, 19), DateTime(2016, 2, 7)],
    'Horse': [DateTime(2014, 1, 31), DateTime(2015, 2, 18)],
    'Snake': [DateTime(2013, 2, 10), DateTime(2014, 1, 30)],
    'Dragon': [DateTime(2012, 1, 23), DateTime(2013, 2, 9)],
    'Boar': [DateTime(2007, 2, 18), DateTime(2008, 2, 6)],
  };
  final zodiacDatesSecond = {
    'Rabbit': [DateTime(2011, 2, 3), DateTime(2012, 1, 22)],
    'Tiger': [DateTime(2010, 2, 14), DateTime(2011, 2, 2)],
    'Ox': [DateTime(2009, 1, 26), DateTime(2010, 2, 13)],
    'Rat': [DateTime(2008, 2, 7), DateTime(2009, 1, 25)],
    'Dog': [DateTime(2006, 1, 29), DateTime(2007, 2, 17)],
    'Rooster': [DateTime(2005, 2, 9), DateTime(2006, 1, 28)],
    'Monkey': [DateTime(2004, 1, 22), DateTime(2005, 2, 8)],
    'Goat': [DateTime(2003, 2, 1), DateTime(2004, 1, 21)],
    'Horse': [DateTime(2002, 2, 12), DateTime(2003, 1, 31)],
    'Snake': [DateTime(2001, 1, 24), DateTime(2002, 2, 11)],
    'Dragon': [DateTime(2000, 2, 5), DateTime(2001, 1, 23)],
    'Pig': [DateTime(1995, 1, 31), DateTime(1996, 2, 18)],
    'Boar': [DateTime(1983, 2, 13), DateTime(1984, 2, 1)],
  };
  final zodiacDatesThird = {
    'Rabbit': [DateTime(1999, 2, 16), DateTime(2000, 2, 4)],
    'Tiger': [DateTime(1998, 1, 28), DateTime(1999, 2, 15)],
    'Ox': [DateTime(1997, 2, 7), DateTime(1998, 1, 27)],
    'Rat': [DateTime(1996, 2, 19), DateTime(1997, 2, 6)],
    'Dog': [DateTime(1994, 2, 10), DateTime(1995, 1, 30)],
    'Rooster': [DateTime(1993, 1, 23), DateTime(1994, 2, 9)],
    'Monkey': [DateTime(1992, 2, 4), DateTime(1993, 1, 22)],
    'Goat': [DateTime(1991, 2, 15), DateTime(1992, 2, 3)],
    'Horse': [DateTime(1990, 1, 27), DateTime(1991, 2, 14)],
    'Snake': [DateTime(1989, 2, 6), DateTime(1990, 1, 26)],
    'Dragon': [DateTime(1988, 2, 17), DateTime(1989, 2, 5)],
  };
  final zodiacDatesFourth = {
    'Rabbit': [DateTime(1987, 1, 29), DateTime(1988, 2, 16)],
    'Tiger': [DateTime(1986, 2, 9), DateTime(1987, 1, 28)],
    'Ox': [DateTime(1985, 2, 20), DateTime(1986, 2, 8)],
    'Rat': [DateTime(1984, 2, 2), DateTime(1985, 2, 19)],
    'Dog': [DateTime(1982, 1, 25), DateTime(1983, 2, 12)],
    'Rooster': [DateTime(1981, 2, 5), DateTime(1982, 1, 24)],
    'Monkey': [DateTime(1980, 2, 16), DateTime(1981, 2, 4)]
  };
  final inputDate = DateTime(year ?? 0, month ?? 0, date ?? 0);
  for (final entry in zodiacDates.entries) {
    String zodiac = entry.key;
    final dateRange = entry.value.map((date) =>
        DateTime(date.year, date.month, date.day)).toList();
    if (inputDate.isAfter(dateRange[0]) && inputDate.isBefore(dateRange[1])) {
      return zodiac;
    }
    else {
      for (final entry2 in zodiacDatesSecond.entries) {
        String zodiac = entry2.key;
        final dateRange = entry2.value.map((date) =>
            DateTime(date.year, date.month, date.day)).toList();
        if (inputDate.isAfter(dateRange[0]) &&
            inputDate.isBefore(dateRange[1])) {
          return zodiac;
        }
        else{
          for (final entry3 in zodiacDatesThird.entries) {
            String zodiac = entry3.key;
            final dateRange = entry3.value.map((date) =>
                DateTime(date.year, date.month, date.day)).toList();
            if (inputDate.isAfter(dateRange[0]) &&
                inputDate.isBefore(dateRange[1])) {
              return zodiac;
            }
            else{
              for (final entry4 in zodiacDatesFourth.entries) {
                String zodiac = entry4.key;
                final dateRange = entry4.value.map((date) =>
                    DateTime(date.year, date.month, date.day)).toList();
                if (inputDate.isAfter(dateRange[0]) &&
                    inputDate.isBefore(dateRange[1])) {
                  return zodiac;
                }
              }
            }
          }
        }
      }
    }
  }
  return 'Unknown';
}