
class Stack<T>{

  factory Stack({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapacityException();

    if(capacity == 0)
      return _ZeroCapacityStack<T>();

    return Stack<T>._(capacity: capacity);
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

class _ZeroCapacityStack<T> extends Stack<T>{
  _ZeroCapacityStack() : super._(capacity: 0);

  @override
  bool get isEmpty => true;

  @override
  int get size => 0;

  @override
  void push(T item) {
    throw StackOverflowException();
  }

  @override
  T pop() {
    throw StackUnderflowException();
  }

  @override
  T peek() {
    throw StackEmptyException();
  }
}

class StackOverflowException implements Exception{}
class StackUnderflowException implements Exception{}
class StackEmptyException implements Exception{}
class IllegalCapacityException implements Exception{}