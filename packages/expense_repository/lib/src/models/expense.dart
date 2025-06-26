import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  TimeOfDay time;
  int amount;

  Expense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.time,
    required this.amount,
});

  static final empty = Expense(
    expenseId: '',
    category: Category.empty,
    date: DateTime.now(),
    time: TimeOfDay.now(),
    amount: 0,
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId: expenseId,
      category: category,
      date: date,
      time: time,
      amount:amount
    );
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId: entity.expenseId,
      category: entity.category,
      date: entity.date,
      time: entity.time,
      amount: entity.amount,
    );
  }
}