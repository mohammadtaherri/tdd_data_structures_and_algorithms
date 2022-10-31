part of linked_list;

class CircularLinkedList<E extends LinkedListEntry<E>> extends _LinkedListBase<E>{


  @override
  void doAfterAddFirst(E? oldFirst){
    _last!.next = _first;
  }

  @override
  void doAfterAddlast(E? oldLast){
    _last!.next = _first;
  }

  @override
  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      var newFirst = _first!.next;
      _first!.next = null;
      _first = newFirst;
      _last!.next = _first;
    }

    _size--;
  }

  @override
  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    if(_first == _last)
      _first = _last = null;
    else{
      _last =_nodeBefore(_last!);
      _last!.next = _first;
    }

    _size--;
  }

  E? _nodeBefore(E node) {
    for (var current = _first; current != null; current = current.next)
      if (current.next == node) return current;

    return null;
  }

  @override
  E elementAt(int index) {
    if(isEmpty)
      throw Empty();

    if(index < 0 || index >= _size)
      throw OutOFRange();

    for(var i = 0, current = first; i <= index; i++, current = current?.next)
      if(i == index)
        return current!;

    throw Error();
  }

  @override
  indexOf(E entry) {
    for (var c = _first, i = 0; c != null; c = c.next, i++)
      if (c == entry) 
        return i;

    return -1;
  }

  @override
  void reverse() {
    if(size <= 1)
      return;
  }
}