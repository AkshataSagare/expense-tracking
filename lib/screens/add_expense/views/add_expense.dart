import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  IconData? selectedCategoryIcon;

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
    'Travel' : [
      {'icon': Icons.mode_of_travel, 'name': 'Travel'},
    ],
    'Bills' : [
      {'icon': Icons.smartphone, 'name': 'Phone Reacharge', },
      {'icon': Icons.lightbulb, 'name': 'Light Bill'},
      {'icon': Icons.gas_meter, 'name': 'Gas Bill'},
    ],
    'Health' : [
      {'icon': Icons.health_and_safety, 'name': 'Health'},
    ],
    'Education' : [
      {'icon': Icons.library_books, 'name': 'Education'},
    ],
    'Others' : [
      {'icon': Icons.local_gas_station_sharp, 'name': 'Petrol'},
      {'icon': Icons.movie, 'name': 'Movie'},
      {'icon': Icons.currency_rupee, 'name': 'Other'},
    ]
  };

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
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
                    Text(item['name'], textAlign: TextAlign.center,style: TextStyle(fontSize: 12)),
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
    return GestureDetector(
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
                    prefixIcon: Icon(Icons.currency_rupee, size: 20, color: Colors.grey),
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
                  prefixIcon: selectedCategoryIcon != null
                      ? Icon(selectedCategoryIcon, size: 20, color: Colors.grey)
                      : Icon(Icons.list, size: 20, color: Colors.grey),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (newDate != null) {
                    setState(() {
                      dateController.text = DateFormat('dd/MM/yyyy').format(newDate);
                      selectedDate = newDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.date_range, size: 20, color: Colors.grey),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: kToolbarHeight,
                child: TextButton(
                  onPressed: () {},
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
