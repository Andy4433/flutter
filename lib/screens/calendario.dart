import 'dart:collection';

import 'package:chuva_dart/models/event_model.dart';
import 'package:chuva_dart/utils/faker_api.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month -3, now.day);
var lastDay = DateTime(now.year, now.month +3, now.day);
CalendarFormat formar = CalendarFormat.twoWeeks;

String locale= 'pt-Br';  

bool load = false;
List<AppEvent> events = [];

var focusedDay = DateTime.now();
var selectedDay = DateTime.now();
 LinkedHashMap<DateTime, List<AppEvent>>? _groupedEvents;

@override

class Caledario extends StatefulWidget {
  const Caledario({super.key});

  @override
  State<Caledario> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Caledario> {
  
  @override
  void initState(){
    addSchedules();
  }

  List<dynamic>_getEventsForDay(DateTime date){
    return _groupedEvents?[date]??[];
  }


  Future addSchedules() async{
    await FakerApi.getData().then((schedules){
    for (var i=0; i< schedules.length; i++){
      events.add(AppEvent(
        date: DateTime.parse(schedules[i].birthday),
        title: schedules[i].firstname,
      ));
    }
      setState((){
        load = true;
      });
    } );
    _groupEvents(events);
  }

int getHashCode(DateTime key){
  return key.day * 1000000 + key.month * 10002 + key.year;
}

_groupEvents(List<AppEvent> events){
  _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
  for (var event in events){
    DateTime date = DateTime.utc(event.date!.year, event.date!. month, event.date!.day, 25);
    if(_groupedEvents![date] == null) _groupedEvents![date] = [];
    _groupedEvents![date]!.add(event);
  }
}

  CalendarFormat format = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          eventLoader: _getEventsForDay,
          onDaySelected: (newSelectedDay, newFocusedDay){
            setState(() {
              selectedDay = newSelectedDay;
              focusedDay = newFocusedDay;
            });
          },
          selectedDayPredicate: (day) => isSameDay(day,selectedDay),
          onFormatChanged: (CalendarFormat _format){
            setState(() {
              format = _format;
            });
          },
                   
          focusedDay: now,
          firstDay: firstDay,
          lastDay:  lastDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.monday, 
          availableCalendarFormats: const{
            CalendarFormat.month: "mês",
            CalendarFormat.week: "semana",
            CalendarFormat.twoWeeks: "2 semanas"
          },
           
           headerStyle: HeaderStyle(
            leftChevronIcon: const Icon(
              Icons.chevron_left,
              size:24,
              color: Colors.black54,
              ),
            rightChevronIcon: const Icon(
              Icons.chevron_left,
              size:24,
              color: Colors.black54,
            ),
            headerPadding: EdgeInsets.zero,
            formatButtonVisible: true,
            formatButtonShowsNext: false,
            formatButtonDecoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
            formatButtonTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            titleTextStyle: const TextStyle(
              color: Colors.blueGrey,
            ),
            titleCentered: true,
           ),

           calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
            ),
            selectedTextStyle: const TextStyle(
              color: Color.fromRGBO(238,230,226,1),
            ),
            todayDecoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
            ),
            todayTextStyle: const TextStyle(
              color: Colors.blueGrey,
            ),
            defaultDecoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            defaultTextStyle: const TextStyle(
              color: Colors.blueGrey,
            ),
            weekendDecoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.rectangle,
            ),
            weekendTextStyle: const TextStyle(color: Colors.blueGrey),
           ),

           calendarBuilders: CalendarBuilders(
            dowBuilder: (context,day){
              String text;
              if(day.weekday == DateTime.sunday){
                text = "dom";
              }else if (day.weekday == DateTime.monday){
                text = "seg";
              }else if (day.weekday == DateTime.tuesday){
                text = "ter";
              }else if (day.weekday == DateTime.wednesday){
                text = "qua";
              }else if (day.weekday == DateTime.thursday){
                text = "qui";
              }else if (day.weekday == DateTime.friday){
                text = "sex";
              }else if (day.weekday == DateTime.saturday){
                text = "sab";
              }else{
                text = "err";
              }
              return Center(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.blueGrey),
                  ),
              );

            }
           ),

          ),
          const SizedBox(height: 16.0,),
        Expanded(child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 30/9,
          children: [
            ..._getEventsForDay(selectedDay).map((event) => Card(
              color: Colors.blueGrey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: ListTile(
                title: Text(
                  event.title.toString(), style: const TextStyle(
                    color: Colors.white, fontSize: 15.0
                    ), 
                    textAlign: TextAlign.center
                    ),
              ),
            ))
          ],
          ))

      ],
    );
  }
}


// import 'package:chuva_dart/screens/screens.dart';
// import 'package:flutter/material.dart';


// void main() {
//   runApp(const ChuvaDart());
// }


// class Calendar extends StatefulWidget {
//   const Calendar({super.key});

//   @override
//   State<Calendar> createState() => _CalendarState();
// }

// class _CalendarState extends State<Calendar> {
//   DateTime _currentDate = DateTime(2023, 11, 26);
//   bool _clicked = false;

//   void _changeDate(DateTime newDate) {
//     setState(() {
//       _currentDate = newDate;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: const Text('Chuva ❤️ Flutter'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'Programação',
//             ),
//             const Text(
//               'Nov',
//             ),
//             const Text(
//               '2023',
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 _changeDate(DateTime(2023, 11, 26));
//               },
//               child: Text(
//                 '26',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 _changeDate(DateTime(2023, 11, 28));
//               },
//               child: Text(
//                 '28',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//             if (_currentDate.day == 26)
//               OutlinedButton(
//                   onPressed: () {
//                     setState(() {
//                       _clicked = true;
//                     });
//                   },
//                   child: const Text('Mesa redonda de 07:00 até 08:00')),
//             if (_currentDate.day == 28)
//               OutlinedButton(
//                   onPressed: () {
//                     setState(() {
//                       _clicked = true;
//                     });
//                   },
//                   child: const Text('Palestra de 09:30 até 10:00')),
//             if (_currentDate.day == 26 && _clicked) const Activity(),
//           ],
//         ),
//       ),
//     );
//   }
// }