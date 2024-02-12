import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { work, food, travel, leisure }

const Iconcategory = {
  Category.food: Icons.lunch_dining,
  Category.work: Icons.work,
  Category.leisure: Icons.movie_creation,
  Category.travel: Icons.flight_takeoff,
};

class Expense {
  Expense(
      {required this.title,
      required this.amound,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amound;
  final DateTime date;
  final Category category;
  String get formatterDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();
  final Category category;
  final List<Expense> expenses;
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amound; //sum= sum + expense.amound
    }
    return sum;
  }
}
