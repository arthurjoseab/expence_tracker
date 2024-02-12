import 'package:expence_tracker/models/expensclass.dart';
import 'package:expence_tracker/widgets/chat/chart.dart';
import 'package:expence_tracker/widgets/expenselist/expense_list.dart';
import 'package:expence_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpense = [
    Expense(
      category: Category.work,
      title: 'This is flutter',
      amound: 203,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.travel,
      title: 'This is an important ',
      amound: 13,
      date: DateTime.now(),
    ),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredexpense.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredexpense.indexOf(expense);
    setState(() {
      _registeredexpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense deleted,'),
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {
          setState(
            () {
              _registeredexpense.insert(expenseIndex, expense);
            },
          );
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final widths = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No expenses found .Start adding some!'),
    );
    if (_registeredexpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredexpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: widths < 600
          ? Column(children: [
              Chart(expenses: _registeredexpense),
              Expanded(child: mainContent),
            ])
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredexpense)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
