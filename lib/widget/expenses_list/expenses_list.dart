import 'package:expence_tracker/widget/expenses_list/expenses_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.4),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpensesItem(expenses[index]),
          confirmDismiss: (direction) async {
            return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Dismisa"),
                    content:
                        Text("Are you sure you want to dismiss this item?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Dismiss the AlertDialog and return false to cancel the Dismissible action
                          Navigator.of(context).pop(false);
                        },
                        child: Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Dismiss the AlertDialog and return true to confirm the Dismissible action
                          Navigator.of(context).pop(true);
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  );
                });
          },
        );
      },
    );
  }
}
