import 'package:flutter/material.dart';


void main(){
  runApp(const MyApp());
}

class Todo{
  bool isDone = false;
  String title;

  Todo(this.title);
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  
  final _items = <Todo>[]; //할일 목록 저장
  
  //할일문자열 조작
  var _todoController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    _todoController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body:GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children:[
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        _addTodo(Todo(_todoController.text));
                      },
                      child: Text('추가')
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: _items.map((todo) => _bulidItemWidget(todo)).toList(),
                  ),
                ),
              ],
            ),
          ),
      ),
      );
  }

  Widget _bulidItemWidget(Todo todo){
    return ListTile(
      onTap: (){
        _toggleTodo(todo);
      },
      title: Text(
        todo.title,
        style: todo.isDone? TextStyle(decoration: TextDecoration.lineThrough,
            fontStyle: FontStyle.italic) : null ,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: (){
          _deleteTodo(todo);
        },
      ),
    );
  }

  void _addTodo(Todo todo){
    setState(() {
      _items.add(todo);
      _todoController.text = ''; //할일 입력필드를 비움
    });
  }
  
  void _deleteTodo(Todo todo){
    setState(() {
      _items.remove(todo);
    });
  }
  
  //완료 / 미완료 변경 메서드
  void _toggleTodo(Todo todo){
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

}
