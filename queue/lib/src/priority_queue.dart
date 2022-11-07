import 'package:queue/queue.dart';

import 'queue_base.dart';

class PriorityQueue<T extends PriorityQueueItem<T>> extends Queue<T>{

  factory PriorityQueue({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapcityException();

    if(capacity == 0)
      return _ZeroCapacityPriorityQueue();

    return PriorityQueue._(capacity: capacity);
  }

  PriorityQueue._({int capacity = 5})
      : _capacity = capacity,
        _items = List.filled(capacity, null);

  final int _capacity;
  final List<T?> _items;

  @override
  bool get isEmpty => _size == 0;

  @override
  bool get isFull => _size == _capacity;

  @override
  int get size => _size;
  int _size = 0;

  @override
  void enqueue(T item) {
    if(isFull)
      throw FullQueueException();

    int lastIndex = _size - 1;

    while(lastIndex > -1){
      T current = _items[lastIndex]!;

      if(current.comparePriorityWith(item) != 1)
        break;

      _items[lastIndex + 1] = current;
      lastIndex--;
    }

    _items[lastIndex + 1] = item;
    _size++;
  }

  @override
  T dequeue() {
    if(isEmpty)
      throw EmptyQueueException();

    return _items[--_size]!;
  }

  @override
  T peek() {
    if(isEmpty)
      throw EmptyQueueException();

    return _items[_size - 1]!;
  } 
}

abstract class PriorityQueueItem<T extends PriorityQueueItem<T>>{

  int comparePriorityWith(T other);
}

class _ZeroCapacityPriorityQueue<T extends PriorityQueueItem<T>> extends PriorityQueue<T> with ZeroCapacityQueue<T>{
  _ZeroCapacityPriorityQueue() : super._(capacity: 0);
}