
class Stack{

  factory Stack({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapacity();

    if(capacity == 0)
      return _ZeroCapacityStack();

    return Stack._(capacity: capacity);
  }

  Stack._({required this.capacity}) : _items = List.filled(capacity, 0);

  final int capacity;
  final List<int> _items;

  int get size => _size;
  int _size = 0;

  bool get isEmpty => _size == 0;

  void push(int item) {
    if(size == capacity)
      throw StackOverFlow();
    
    _items[_size++] = item;
  }

  int pop() {
    if(isEmpty)
      throw StackUnderFlow();

    return _items[--_size];
  }

  int top() {
    if(isEmpty)
      throw StackEmpty();

    return _items[size-1];
  }
}


class _ZeroCapacityStack extends Stack{
  _ZeroCapacityStack(): super._(capacity: 0);

  @override
  int get size => 0;

  @override
  bool get isEmpty => true;

  @override
  void push(int item) {
    throw StackOverFlow();
  }

  @override
  int pop() {
    throw StackUnderFlow();
  }

  @override
  int top() {
    throw StackEmpty();
  }
}


class StackOverFlow implements Exception{}

class StackUnderFlow implements Exception{}

class StackEmpty implements Exception{}

class IllegalCapacity implements Exception{}