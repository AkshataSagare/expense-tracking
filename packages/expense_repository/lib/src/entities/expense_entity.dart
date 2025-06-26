import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  TimeOfDay time;
  int amount;

  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.time,
    required this.amount,
});

  Map<String, Object> toDocument() {
    return {
      'expenseId': expenseId,
      'category': category.toEntity().toDocument(),
      'date': DateTime.now().toIso8601String(),
      'time': TimeOfDay.now(),
      'amount': amount,
    };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic>doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'],
      category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date:DateTime.parse(doc['date']).toLocal(),
      time:,
      amount: doc['amount'],
    );
  }
}