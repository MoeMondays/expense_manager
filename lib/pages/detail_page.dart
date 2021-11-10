import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/accounts/account.dart';
import 'package:project/pages/new_detail_page.dart';

class DetailPage extends StatefulWidget {
  static const routeName = "/detail";

  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var account = ModalRoute.of(context)!.settings.arguments as Account;

    return Scaffold(
      appBar: AppBar(title: Text(account.name),),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          )
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCurrentBalance(account),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "HISTORY",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ),
            _buildHistory(account),
            _buildActionPanel(account),
          ],
        ),
      ),
    );
  }

  _buildCurrentBalance(Account account) {
    return Container(
      decoration: BoxDecoration(
        color: account.bank>=0
            ? Colors.blue.withOpacity(0.8)
            : Colors.red.withOpacity(0.8),
      ),

      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("CURRENT BALANCE:",
              style: TextStyle(fontSize: 20, color: Colors.black54,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  account.bank.toString(),
                  style: const TextStyle(fontSize: 100, color: Colors.white),
                ),
                const Text("฿",
                  style: TextStyle(fontSize: 100, color: Colors.black38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildHistory(Account account){
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),

        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
          child: ListView.builder(
            itemCount: account.history.length,
            itemBuilder: (context, index){
              int reverse = (account.history.length-1)-index;

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      account.history[reverse]["title"],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        account.history[reverse]["bank"].toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: account.history[reverse]["bank"]>=0
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                      const Text("฿  ", style: TextStyle(fontSize: 20),),
                    ],
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  _buildActionPanel(Account account){
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                _clearHistoryButton(account);
              },
              child: const Text("CLEAR HISTORY", style: TextStyle(fontSize: 20),),
            ),
          ),
          const SizedBox(width: 5,),
          Expanded(
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(
                  context,
                  NewDetailPage.routeName,
                  arguments: account,
                ).then((value) => setState((){}));
              },
              child: const Text("NEW", style: TextStyle(fontSize: 20),),
            ),
          ),
        ],
      ),
    );
  }

  _clearHistoryButton(Account account){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text("CLEAR HISTORY"),
          content: const Text("Are you sure you want to clear this account history?"),
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
                  account.clearHistory();
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
