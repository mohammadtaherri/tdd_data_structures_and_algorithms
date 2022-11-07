import 'package:linked_list/linked_list.dart';
import './queue_base.dart';

class LinkedListQueue<T> extends QueueBase<T>{

  factory LinkedListQueue({int capacity = 5}) => QueueBase<T>.make(
        capacity: capacity,
        maker: () => capacity == 0
            ? _ZeroCapacityLinkedListQueue()
            : LinkedListQueue<T>._(capacity: capacity),
      ) as LinkedListQueue<T>;

  LinkedListQueue._({super.capacity})
      : _items = SinglyLinkedList();

  final LinkedList<_QueueEntry<T>> _items;

  @override
  void internalEnqueue(T item) {
    _items.addLast(_QueueEntry(item));
  }

  @override
  T internalDequeue() {
    T item = _items.first!.value;
    _items.removeFirst();
    return item;
  }

  @override
  T internalPeek() {
    return _items.first!.value;
  }
}

class _QueueEntry<T> extends LinkedListEntry<_QueueEntry<T>>{
  _QueueEntry(this.value);
  final T value;
}

class _ZeroCapacityLinkedListQueue<T> extends LinkedListQueue<T> with ZeroCapacityQueue<T>{
  _ZeroCapacityLinkedListQueue() : super._(capacity: 0);
}