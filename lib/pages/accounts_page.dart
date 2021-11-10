import 'package:flutter/material.dart';
import 'package:project/accounts/account.dart';
import 'package:project/pages/detail_page.dart';

class AccountsPage extends StatefulWidget {
  static const routeName = "/accounts";

  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController _newAccNameController = TextEditingController();
  final TextEditingController _newAccNumController = TextEditingController();
  List<Account> accounts = [
    Account("Account1", 10000, hist:[{"title": "Income", "bank": 10000}]),
    Account("Account2", -2500, hist:[{
      "title": "Income", "bank": 2500
    },{
      "title": "Expense", "bank": -5000
    }]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EXPENSE MANAGER"),),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          )
        ),

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: _buildAccountButton(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _newAccountButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView _buildAccountButton() {
    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index){
        Account account = accounts[index];

        return Card(
          color: Colors.black.withOpacity(0.2),
          margin: const EdgeInsets.all(5),
          child: InkWell(
            onTap: (){
              Navigator.pushNamed(
                context,
                DetailPage.routeName,
                arguments: account,
              ).then((value) => setState((){}));
            },
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.name,
                          style: const TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Text(
                              "Balance: ",
                              style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.3)),),
                            Text(
                              "${account.bank}฿",
                              style: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.8),
                  ),

                  child: InkWell(
                    onTap: (){
                      _editAccountButton(index);
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                  ),

                  child: InkWell(
                    onTap: (){
                      _deleteAccountButton(index);
                    },
                    child: const Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
              ],
            ),
          ),
        );
      },
    );
  }

  _newAccountButton(){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("NEW ACCOUNT"),
          content: Wrap(
            children: [
              Column(
                children: [
                  const Text("Account Name:"),
                  TextField(
                    controller: _newAccNameController,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Balance:"),
                  TextField(
                    controller: _newAccNumController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _newAccNameController.clear();
                _newAccNumController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: (){
                String name = _newAccNameController.text;
                int? num = int.tryParse(_newAccNumController.text);
                setState(() {
                  if(name!="" && num!=null) {
                    accounts.add(Account(name, num, hist:[{
                      "title": "New Balance", "bank": num
                    }]));
                  }
                });
                _newAccNameController.clear();
                _newAccNumController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CONFIRM"),
            ),
          ],
        );
      },
    );
  }

  _editAccountButton(int index){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("EDIT ACCOUNT"),
          content: Wrap(
            children: [
              Column(
                children: [
                  const Text("Account Name:"),
                  TextField(
                    controller: _newAccNameController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: accounts[index].name,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text("Balance:"),
                  TextField(
                    controller: _newAccNumController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: accounts[index].bank.toString(),
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: (){
                _newAccNameController.clear();
                _newAccNumController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: (){
                String name = _newAccNameController.text;
                int? num = int.tryParse(_newAccNumController.text);
                setState(() {
                  if(name != "") {
                    accounts[index].rename(name);
                  }
                  if(num != null) {
                    accounts[index].newBalance(num);
                    accounts[index].addHistory({"title":"New Balance", "bank":num});
                  }
                });
                _newAccNameController.clear();
                _newAccNumController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CONFIRM"),
            ),
          ],
        );
      },
    );
  }

  _deleteAccountButton(int index){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("DELETE ACCOUNT"),
          content: Text("Are you sure you want to delete \"${accounts[index].name}\"?"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("NO"),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  accounts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("YES"),
            ),
          ],
        );
      },
    );
  }
}
