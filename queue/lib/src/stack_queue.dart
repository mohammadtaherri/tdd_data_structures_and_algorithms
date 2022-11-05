import 'package:stack/stack.dart';
import './queue_base.dart';

class StackQueue<T> extends QueueBase<T>{

  factory StackQueue({int capacity = 5}) => QueueBase<T>.make(
        capacity: capacity,
        maker: () => capacity == 0
            ? _ZeroCapacityStackQueue()
            : StackQueue._(capacity: capacity),
      ) as StackQueue<T>;

  StackQueue._({super.capacity})
      : _enqueuingStack = Stack(capacity: capacity),
        _dequeuingStack = Stack(capacity: capacity);

  final Stack<T> _enqueuingStack;
  final Stack<T> _dequeuingStack;

  @override
  void internalEnqueue(T item) {
    _enqueuingStack.push(item);
  }

  @override
  T internalDequeue() {
    if(_dequeuingStack.isEmpty)
      while(!_enqueuingStack.isEmpty)
        _dequeuingStack.push(_enqueuingStack.pop());

    return _dequeuingStack.pop();
  }

  @override
  T internalPeek() {
    if(_dequeuingStack.isEmpty)
      while(!_enqueuingStack.isEmpty)
          _dequeuingStack.push(_enqueuingStack.pop());

    return _dequeuingStack.peek();
  }
}

class _ZeroCapacityStackQueue<T> extends StackQueue<T> with ZeroCapacityQueue<T>{
  _ZeroCapacityStackQueue() : super._(capacity: 0);
}