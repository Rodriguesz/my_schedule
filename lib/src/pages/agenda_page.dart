import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';
import '../models/date.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  DateTime date = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Todo> _todos = [];

  @override
  void initState() {
    initializeDateFormatting('pt_BR');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Image(
          image: AssetImage('lib/assets/150.png'),
          fit: BoxFit.cover,
        ),
        toolbarHeight: 100,
        centerTitle: true,
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
                  onPressed: _selectDate,
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
                            border: Border.all(color: Colors.white, width: 1.5),
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
                            border: Border.all(color: Colors.white, width: 1.5),
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
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    leading: Icon(
                      todo.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: todo.isDone ? Colors.green : Colors.blue,
                      size: 24,
                    ),
                    title: Text(
                      todo.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          todo.description,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Data: ${DateFormat('dd/MM/yy').format(todo.date.day)}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 10), // Espaço entre a data e a hora
                            Text(
                              "Hora: ${todo.date.time.format(context)}",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          _todos.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        todo.isDone = !todo.isDone;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoForm,
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        tooltip: 'Increment',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showAddTodoForm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Tarefa'),
          content: _addTodoForm(),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  setState(() {
                    _todos.add(Todo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      date: Date(day: date, time: _selectedTime),
                      isDone: false,
                    ));
                    _titleController.clear();
                    _descriptionController.clear();
                    _selectedTime = TimeOfDay.now();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Widget _addTodoForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titulo',
                labelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Insira o titulo da atividade',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                hintText: 'Insira a descrição da atividade',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a descrição';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _selectTime(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Text(
                          'Hora selecionada: ${_selectedTime.format(context)}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        date = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
