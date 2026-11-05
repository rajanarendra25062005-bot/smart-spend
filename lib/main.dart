import 'package:flutter/material.dart';

void main() {
  runApp(SmartSpendApp());
}

class SmartSpendApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Spend',
      home: HomeScreen(),
    );
  }
}

class Expense {
  String title;
  double amount;
  Expense({required this.title, required this.amount});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  double get total {
    double sum = 0;
    for (var e in expenses) sum += e.amount;
    return sum;
  }

  void addExpense() {
    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
      setState(() {
        expenses.add(Expense(
          title: titleController.text,
          amount: double.parse(amountController.text),
        ));
      });
      titleController.clear();
      amountController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Spend"), centerTitle: true),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text("Total Spend"),
                Text("Rs. $total",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                Text("${expenses.length} Expenses"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Title - Ex: Food, Bus",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Amount",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: addExpense,
                    child: Text("Add Expense"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: expenses.isEmpty
                ? Center(child: Text("No Expenses Yet"))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      var e = expenses[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(child: Icon(Icons.money)),
                          title: Text(e.title),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Rs. ${e.amount}"),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    expenses.removeAt(index);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
