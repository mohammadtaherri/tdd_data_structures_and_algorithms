import './queue_base.dart';

class ArrayQueue<T> extends QueueBase<T>{

  factory ArrayQueue({int capacity = 5}) => QueueBase<T>.make(
        capacity: capacity,
        maker: () => capacity == 0
            ? _ZeroCapacityArrayQueue()
            : ArrayQueue<T>._(capacity: capacity),
      ) as ArrayQueue<T>;

  ArrayQueue._({super.capacity}) 
      : _items = List.filled(capacity, null);
  
  final List<T?> _items;
  int _back = 0;
  int _front = 0;

  @override
  void internalEnqueue(T item) {
    _front %= _items.length;
    _items[_front++] = item;
  }

  @override
  T internalDequeue() {
    _back %= _items.length;
    return _items[_back++]!;
  }

  @override
  T internalPeek() {
    return _items[_back]!;
  }
}

class _ZeroCapacityArrayQueue<T> extends ArrayQueue<T> with ZeroCapacityQueue<T>{
  _ZeroCapacityArrayQueue() : super._(capacity: 0);
}