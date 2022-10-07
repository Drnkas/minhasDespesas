import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}
class _TransactionFormState extends State<TransactionForm> {

  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm(){ //faz com que ao apertar em "ok" no teclado envie os dados
      final title = _titleController.text;
      final value = double.tryParse(_valueController.text) ?? 0.0;

      if(title.isEmpty || value <= 0 || _selectedDate == null) {
        return;
      }
      widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                  labelText:'Título'
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true), //ios e android
              onSubmitted: (_) => _submitForm(), //ignora o parametro que foi passado (_)
              decoration: const InputDecoration(
                  labelText: 'Valor'
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada'
                            : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar data',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
