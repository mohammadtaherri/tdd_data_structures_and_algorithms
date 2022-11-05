
import 'package:queue/queue.dart';
import 'package:linked_list/linked_list.dart';

class LinkedListQueue<T>{

  factory LinkedListQueue({int capacity = 5}){
    if(capacity < 0)
      throw IllegalCapcityException();

    if(capacity == 0)
      return _ZeroCapcityLinkedListQueue<T>();

    return LinkedListQueue._(capacity: capacity);
  }

  LinkedListQueue._({int capacity = 5})
      : _capacity = capacity,
        _items = SinglyLinkedList();

  final int _capacity;
  final LinkedList<_QueueEntry<T>> _items;

  bool get isEmpty => _size == 0;
  bool get isFull => _size == _capacity;
  int get size => _size;
  int _size = 0;

  void enqueue(T item) {
    if(isFull)
      throw FullQueueException();

    _items.addLast(_QueueEntry(item));
    _size++;
  }

  T dequeue() {
    if(isEmpty)
      throw EmptyQueueException();
    
    _size--;
    T item = _items.first!.value;
    _items.removeFirst();
    return item;
  }

  T peek() {
    if(isEmpty)
      throw EmptyQueueException();

    return _items.first!.value;
  }
}

class _ZeroCapcityLinkedListQueue<T> extends LinkedListQueue<T>{

  _ZeroCapcityLinkedListQueue() : super._(capacity: 0);

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
  dequeue() {
    throw EmptyQueueException();
  }

  @override
  peek() {
    throw EmptyQueueException();
  }
}

class _QueueEntry<T> extends LinkedListEntry<_QueueEntry<T>>{

  _QueueEntry(this.value);
  final T value;
}