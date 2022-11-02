

import 'package:linked_list_composition/linked_list.dart';

class SinglyLinkedList<E extends LinkedListEntry<E>> implements LinkedList<E>{

  @override
  bool get isEmpty => _size == 0;

  @override
  int get size => _size;
  int _size = 0;

  @override
  E? get first => _first;
  E? _first;

  @override
  E? get last => _last;
  E? _last;

  @override
  void addFirst(E entry) {
    var oldFirst = _first;

    if(isEmpty)
      _initFirstAndLastTo(entry);
    else
      _changeFirstTo(entry);

    _updateLinks(previous: _first, next: oldFirst);
    _incrementSizebyOne();
  }

  @override
  void addLast(E entry) {
    var oldLast = _last;

    if(isEmpty)
      _initFirstAndLastTo(entry);
    else{
      _changeLastTo(entry);
    }

    _updateLinks(previous: oldLast, next: _last);
    _incrementSizebyOne();
  }

  @override
  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    var oldFirst = _first;

    if(_sizeIsOne)
      _clearFirstAndLast();
    else
      _changeFirstTo(_first!.next);
    
    _unlink(oldFirst);
    _decrementSizeByOne();
  }

  @override
  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    if(_sizeIsOne)
      _clearFirstAndLast();
    else
      _changeLastTo(_nodeBefor(_last!));
    
    _unlink(_last);
    _decrementSizeByOne();
  }

  bool get _sizeIsOne => _first == _last;

  void _initFirstAndLastTo(entry) {
    _first = _last = entry;
  }

  void _clearFirstAndLast() {
    _first = _last = null;
  }

  void _changeFirstTo(entry) {
    _first = entry;
  }

  void _changeLastTo(entry) {
    _last = entry;
  }

  E? _nodeBefor(E node) {
    
    for (var current = _first; current != null; current = current.next) 
      if (current.next == _last) 
        return current;

    return null;
  }

  void _updateLinks({E? previous, E? next}){
    previous?.next = next;
  }

  void _unlink(E? node){
    node?.next = null;
  }

  void _incrementSizebyOne() {
    _size++;
  }

  void _decrementSizeByOne() {
    _size--;
  }

  @override
  E elementAt(int index) {
    if(isEmpty)
      throw Empty();

    if(index < 0 || index >= size)
      throw OutOFRange();

    for(var i = 0, current = first; i <= index; i++, current = current?.next)
      if(i == index)
        return current!;

    throw Error();
  }

  @override
  int indexOf(E entry) {
    for (var c = _first, i = 0; c != null; c = c.next, i++)
      if (c == entry) 
        return i;

    return -1;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;

    _reverseLinks();
    _reverseFirstAndLast();
    _unlink(last);
  }

  void _reverseLinks() {
    var previous = first;
    var current = first!.next;
    
    while(current != null){
      var temp = current.next;
      current.next = previous;
      previous = current;
      current = temp;
    }
  }

  void _reverseFirstAndLast() {
    var temp = first;
    _first = _last;
    _last = temp;
  }

  
}