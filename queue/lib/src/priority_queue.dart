import 'queue_base.dart';

class PriorityQueue<T extends PriorityQueueItem<T>> extends QueueBase<T>{

  factory PriorityQueue({int capacity = 5}) => QueueBase<T>.make(
        capacity: capacity,
        maker: () => capacity == 0
            ? _ZeroCapacityPriorityQueue()
            : PriorityQueue._(capacity: capacity),
      ) as PriorityQueue<T>;

  PriorityQueue._({super.capacity})
      : _items = List.filled(capacity, null);

  final List<T?> _items;

  @override
  void internalEnqueue(T item) {
    final index = _shiftItemsToInsert(item);
    _items[index] = item;
  }

  int _shiftItemsToInsert(item) {
    int lastIndex = size - 1;

    for(;lastIndex > -1; lastIndex--){
      T current = _items[lastIndex]!;
    
      if(current.comparePriorityWith(item) != 1)
        break;
    
      _items[lastIndex + 1] = current;
    }

    return lastIndex + 1;
  }

  @override
  T internalDequeue() {
    return _items[size]!;
  }

  @override
  T internalPeek() {
    return _items[size - 1]!;
  } 
}

abstract class PriorityQueueItem<T extends PriorityQueueItem<T>>{
  int comparePriorityWith(T other);
}

class _ZeroCapacityPriorityQueue<T extends PriorityQueueItem<T>> extends PriorityQueue<T> with ZeroCapacityQueue<T>{
  _ZeroCapacityPriorityQueue() : super._(capacity: 0);
}