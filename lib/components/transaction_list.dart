import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        //precisa de um tamanho pré definido pelo pai
        height: 1000,
        //builder chama cada item a partir do momento que precisar
        // assim não sobrecarrega o app ocupando memória dos itens já carregados

        child: transactions.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Nenhuma transação cadastrada!"),
                  const SizedBox(height: 20),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemCount: transactions.length, //qts de itens na lista

                itemBuilder: (ctx, index) {
                  //faz o carregamento de acordo com o parâmentro
                  final tr = transactions[index];

                  return Card(
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('R\$${tr.value}')
                          ),
                        ),
                      ),
                      title: Text(
                          tr.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      subtitle: Text(
                          DateFormat('d MMM y').format(tr.date)
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.black,
                        onPressed: () => onRemove(tr.id),
                      ),
                    ),
                  );
                }
                )
    );
  }
}
