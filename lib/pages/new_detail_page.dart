import 'package:flutter/material.dart';
import 'package:project/accounts/account.dart';

class NewDetailPage extends StatefulWidget {
  static const routeName = "/new";

  const NewDetailPage({Key? key}) : super(key: key);

  @override
  _NewDetailPageState createState() => _NewDetailPageState();
}

class _NewDetailPageState extends State<NewDetailPage> {
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var account = ModalRoute.of(context)!.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(title: const Text("NEW INCOME/EXPENSE"),),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          )
        ),

        child: _buildButton(account),
      ),
    );
  }

  Padding _buildButton(Account account) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                _incomeAction(account);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.monetization_on,
                    size: 100,
                  ),
                  Text("INCOME", style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
          ),
          const SizedBox(height: 50,),
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                _expenseAction(account);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                  ),
                  Text("EXPENSE", style: TextStyle(fontSize: 30),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _incomeAction(Account account){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("NEW INCOME"),
          content: Wrap(
            children: [
              Column(
                children: [
                  const Text("Description:"),
                  TextField(
                    controller: _detailController,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Amount:"),
                  TextField(
                    controller: _bankController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ]
          ),
          actions: [
            TextButton(
              onPressed: (){
                _detailController.clear();
                _bankController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: (){
                String detail = _detailController.text;
                int? bank = int.tryParse(_bankController.text);
                bool done = false;
                setState(() {
                  if(bank != null){
                    account.income(bank);
                    if(detail != ""){
                      account.addHistory({"title":detail, "bank":bank});
                    }
                    else{
                      account.addHistory({"title":"Income", "bank":bank});
                    }
                    done = true;
                  }
                });
                _detailController.clear();
                _bankController.clear();
                Navigator.of(context).pop();
                if(done){
                  Navigator.pop(context);
                }
              },
              child: const Text("CONFIRM"),
            ),
          ],
        );
      },
    );
  }

  _expenseAction(Account account){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("NEW EXPENSE"),
          content: Wrap(
            children: [
              Column(
                children: [
                  const Text("Description:"),
                  TextField(
                    controller: _detailController,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10,),
                  const Text("Amount:"),
                  TextField(
                    controller: _bankController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ]
          ),
          actions: [
            TextButton(
              onPressed: (){
                _detailController.clear();
                _bankController.clear();
                Navigator.of(context).pop();
              },
              child: const Text("CANCEL"),
            ),
            TextButton(
              onPressed: (){
                String detail = _detailController.text;
                int? bank = int.tryParse(_bankController.text);
                bool done = false;
                setState(() {
                  if(bank != null){
                    account.expense(bank);
                    if(detail != ""){
                      account.addHistory({"title":detail, "bank":-bank});
                    }
                    else{
                      account.addHistory({"title":"Expense", "bank":-bank});
                    }
                    done = true;
                  }
                });
                _detailController.clear();
                _bankController.clear();
                Navigator.of(context).pop();
                if(done){
                  Navigator.pop(context);
                }
              },
              child: const Text("CONFIRM"),
            ),
          ],
        );
      },
    );
  }
}
