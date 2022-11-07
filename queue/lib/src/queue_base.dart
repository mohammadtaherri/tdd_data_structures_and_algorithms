
import 'package:meta/meta.dart';
import 'package:queue/queue.dart';

abstract class QueueBase<T> implements Queue<T>{

  factory QueueBase.make({
    int capacity = 5,
    required QueueBase<T> Function() maker,
  }) {
    if (capacity < 0) 
      throw IllegalCapcityException();

    return maker();
  }

  QueueBase({int capacity = 5}) : _capacity = capacity;

  final int _capacity;

  @override
  bool get isEmpty => _size == 0;

  @override
  bool get isFull => _size == _capacity;

  @override
  int get size => _size;
  int _size = 0;

  @override
  void enqueue(T item) {
    _validateForEnqueuing();
    internalEnqueue(item);
    _incrementSizeByOne();
  }

  bool _validateForEnqueuing(){
    if(isFull)
      throw FullQueueException();

    return true;
  }

  void _incrementSizeByOne(){
    _size++;
  }

  @protected
  void internalEnqueue(T item);

  @override
  T dequeue() {
    _validateForDequeuing();
    _decrementSizeByOne();
    return internalDequeue();
  }

  bool _validateForDequeuing(){
    if(isEmpty)
      throw EmptyQueueException();

    return true;
  }

  void _decrementSizeByOne(){
    _size--;
  }

  @protected
  T internalDequeue();

  @override
  T peek() {
    _validateForPeeking();
    return internalPeek();
  }

  bool _validateForPeeking(){
    if(isEmpty)
      throw EmptyQueueException();

    return true;
  }

  @protected
  T internalPeek();
}

mixin ZeroCapacityQueue<T> on Queue<T>{

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