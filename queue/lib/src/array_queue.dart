import 'package:queue/queue.dart';

import './errors.dart';

class ArrayQueue<T> implements Queue<T>{

  factory ArrayQueue({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapcityException();

    if(capacity == 0)
      return _ZeroCapacityArrayQueue<T>();

    return ArrayQueue._(capacity: capacity);
  }

  ArrayQueue._({required int capacity}) 
      : _items = List.filled(capacity, null);
  
  final List<T?> _items;
  int _back = 0;
  int _front = 0;

  @override
  bool get isEmpty => _size == 0;

  @override
  bool get isFull => _size == _items.length;

  @override
  int get size => _size;
  int _size = 0;

  @override
  void enqueue(T item) {
    if(isFull)
      throw FullQueueException();
    
    _front %= _items.length;
    _items[_front++] = item;
    _size++;
  }

  @override
  T dequeue() {
    if(isEmpty)
      throw EmptyQueueException();

    _size--;
    _back %= _items.length;
    return _items[_back++]!;
  }

  @override
  T peek() {
    if(isEmpty)
      throw EmptyQueueException();

    return _items[_back]!;
  }
}

class _ZeroCapacityArrayQueue<T> extends ArrayQueue<T>{

  _ZeroCapacityArrayQueue() : super._(capacity: 0);

  @override
  get isEmpty => true;

  @override
  get isFull => true;
  
  @override
  get size => 0;

  @override
  void enqueue(T item) {
    throw FullQueueException();
  }

  @override
  dequeue() {
    throw EmptyQueueException();
  }

  @override
  peek() {
    throw EmptyQueueException();
  }
}
