

import 'package:queue/queue.dart';
import 'package:stack/stack.dart';

class StackQueue<T>{

  factory StackQueue({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapcityException();

    if(capacity == 0)
      return _ZeroCapacityStackQueue<T>();

    return StackQueue._(capacity: capacity);
  }

  StackQueue._({int capacity = 5}) : _capacity = capacity, _enqueuingStack = Stack(capacity: capacity), _dequeuingStack = Stack(capacity: capacity);

  final int _capacity;
  final Stack<T> _enqueuingStack;
  final Stack<T> _dequeuingStack;

  bool get isEmpty => _size == 0;
  bool get isFull => _size == _capacity;
  int get size => _size;
  int _size = 0;

  void enqueue(T item) {
    if(isFull)
      throw FullQueueException();

    _size++;
    _enqueuingStack.push(item);
  }

  dequeue() {
    if(isEmpty)
      throw EmptyQueueException();

    _size--;

    if(_dequeuingStack.isEmpty)
      while(!_enqueuingStack.isEmpty)
        _dequeuingStack.push(_enqueuingStack.pop());

    return _dequeuingStack.pop();
  }

  peek() {
    if(isEmpty)
      throw EmptyQueueException();

    if(_dequeuingStack.isEmpty)
      while(!_enqueuingStack.isEmpty)
          _dequeuingStack.push(_enqueuingStack.pop());

    return _dequeuingStack.peek();
  }
}

class _ZeroCapacityStackQueue<T> extends StackQueue<T>{

  _ZeroCapacityStackQueue() : super._(capacity: 0);

  @override
  bool get isEmpty => true;

  @override
  bool get isFull => true;

  @override
  int get size => 0;

  @override
  void enqueue(T item) {
    throw FullQueueException();
  }

  @override
  T dequeue() {
    throw EmptyQueueException();
  }

  @override
  T peek() {
    throw EmptyQueueException();
  }
}