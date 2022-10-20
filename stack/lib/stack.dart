
class Stack<T>{

  factory Stack({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapacityException();

    return Stack._(capacity: capacity);
  }

  Stack._({int capacity = 5}) : _items = List.filled(capacity, null);

  final List<T?> _items;

  bool get isEmpty => _size == 0;
  int get size => _size;
  int _size = 0;

  void push(T item) {
    if(_isFull)
      throw StackOverflowException();

    _items[_size++] = item;
  }

  bool get _isFull => _size == _items.length;

  T pop() {
    if(isEmpty)
      throw StackUnderflowException();

    return _items[--_size]!;
  }

  T peek() {
    if(isEmpty)
      throw StackEmptyException();

    return _items[size-1]!;
  }
}

class StackOverflowException implements Exception{}
class StackUnderflowException implements Exception{}
class StackEmptyException implements Exception{}
class IllegalCapacityException implements Exception{}