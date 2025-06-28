import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracking/screens/add_expense/bloc/create_categorybloc/create_category_bloc.dart';
import 'package:expense_tracking/screens/add_expense/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:expense_tracking/screens/add_expense/bloc/get_categories_bloc/get_categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  IconData? selectedCategoryIcon;
  late Expense expense;
  bool isLoading = false;
  Category category = Category.empty;

  final Map<String, List<Map<String, dynamic>>> categoryIcons = {
    'Food': [
      {'icon': Icons.food_bank, 'name': 'Food'},
    ],
    'Shopping': [
      {'icon': Icons.local_grocery_store, 'name': 'Grocery'},
      {'icon': Icons.checkroom, 'name': 'Clothing'},
      {'icon': Icons.phone_android, 'name': 'Electronics'},
      {'icon': Icons.book, 'name': 'Books'},
      {'icon': Icons.edit, 'name': 'Stationary'},
    ],
    'Travel': [
      {'icon': Icons.mode_of_travel, 'name': 'Travel'},
    ],
    'Bills': [
      {'icon': Icons.smartphone, 'name': 'Phone Reacharge'},
      {'icon': Icons.lightbulb, 'name': 'Light Bill'},
      {'icon': Icons.gas_meter, 'name': 'Gas Bill'},
    ],
    'Health': [
      {'icon': Icons.health_and_safety, 'name': 'Health'},
    ],
    'Education': [
      {'icon': Icons.library_books, 'name': 'Education'},
    ],
    'Others': [
      {'icon': Icons.local_gas_station_sharp, 'name': 'Petrol'},
      {'icon': Icons.movie, 'name': 'Movie'},
      {'icon': Icons.currency_rupee, 'name': 'Other'},
    ],
  };

  @override
  void initState() {
    expense = Expense.empty;
    expense.date = DateTime.now();
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  void showIconPicker(BuildContext context) {
    final allItems = categoryIcons.entries.expand((e) => e.value).toList();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 400,
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: allItems.map((item) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategoryIcon = item['icon'];
                    categoryController.text = item['name'];
                  });
                  Navigator.pop(context);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200],
                      child: Icon(item['icon'], color: Colors.blue),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item['name'],
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          final savedExpense = Expense(
            expenseId: expense.expenseId,
            category: expense.category,
            amount: expense.amount,
            date: expense.date,
          );
          setState(() {
            expense = Expense.empty;
            expense.expenseId = const Uuid().v1();
            expense.category = Category.empty;
            expense.date = DateTime.now();
            expenseController.clear();
            categoryController.clear();
            selectedCategoryIcon = null;
          });
          Navigator.pop(context, savedExpense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Expenses',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 32),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: expenseController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                        size: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: categoryController,
                  textAlignVertical: TextAlignVertical.center,
                  readOnly: true,
                  onTap: () => showIconPicker(context),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      selectedCategoryIcon ??(
                        expense.category != Category.empty
                        ? CategoryEntity.getIcon(expense.category.icon)
                        : Icons.list
                        ),
                      size: 20,
                      color: Colors.grey,
                    ),
                    hintText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                      builder: (context, state) {
                        if (state is GetCategoriesSuccess) {
                          return ListView.builder(
                            itemCount: state.categories.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = state.categories[i];
                                      categoryController.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Icon(
                                    CategoryEntity.getIcon(
                                      state.categories[i].icon,
                                    ),
                                  ),
                                  title: Text(state.categories[i].name),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: expense.date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (newDate != null) {
                      setState(() {
                        expense.date = newDate;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.date_range, size: 20, color: Colors.grey),
                        SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            DateFormat('dd MMM yyyy').format(expense.date),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        expense.date = DateTime(
                          expense.date.year,
                          expense.date.month,
                          expense.date.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            DateFormat('hh:mm').format(expense.date),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: kToolbarHeight,
                  child: isLoading
                      ? Center(child: CircularProgressIndicator())
                      : TextButton(
                          onPressed: () {
                            if (selectedCategoryIcon != null) {
                              category.categoryId = Uuid().v1();
                              category.name = categoryController.text;
                              category.icon = CategoryEntity.getIconString(
                                selectedCategoryIcon!,
                              );
                              context.read<CreateCategoryBloc>().add(
                                CreateCategory(category),
                              );
                            } else {}
                            setState(() {
                              expense.amount = int.parse(
                                expenseController.text,
                              );
                            });
                            context.read<CreateExpenseBloc>().add(
                              CreateExpense(expense),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
