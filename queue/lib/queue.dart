
export './src/array_queue.dart';
export './src/linked_list_queue.dart';
export './src/stack_queue.dart';
export './src/priority_queue.dart';
export './src/errors.dart';

abstract class Queue<T>{

  bool get isEmpty;
  bool get isFull;
  int get size;

  void enqueue(T item);

  T dequeue();

  T peek();
}