import 'package:flutter/material.dart';
import 'package:my_schedule/src/pages/agenda_page.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return MaterialApp(
        home: AgendaPage(),
       );
  }
}