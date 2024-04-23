import 'package:flutter/material.dart';
import '../models/todo.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('MySchedule',
                style: TextStyle(
                  color: Colors.white,
                )),
            centerTitle: true,
            backgroundColor: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(600),
            ))),
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
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: const Center(
                          child: Text(
                            'Tarefas do dia',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ,
            //   child: const Center(
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(Icons.calendar_month),
            //         SizedBox(
            //           width: 15,
            //         ),
            //         Text('Atividades do dia 22/04/2024')
            //       ],
            //     ),
            //   ),
            // )
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
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2100));
  }
}
