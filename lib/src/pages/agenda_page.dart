import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime date = DateTime.now();

  @override
  void initState() {
    initializeDateFormatting('pt_BR');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/pequeno.png', fit: BoxFit.cover),
          backgroundColor: const Color.fromARGB(255, 40, 145, 249),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(70),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(7, 13, 7, 0),
              child: Row(
                children: [
                  FloatingActionButton(
                    onPressed: () => _selectDate(),
                    elevation: 8,
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.calendar_month,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              DateFormat('dd/MM/yy').format(date),
                              style: const TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.blue),
                          child: const Center(
                            child: Text(
                              "Atividades do dia",
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _addTodo(Todo todo) {
    return ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.description),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        date = picked;
      });
    }
  }
}
