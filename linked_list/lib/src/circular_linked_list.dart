part of linked_list;

class CircularLinkedList<E extends LinkedListEntry<E>>{
  get isEmpty => _size == 0;

  get size => _size;
  int _size = 0;

  get first => _first;
  E? _first;

  get last => _last;
  E? _last;

  void addFirst(E entry) {
    if(isEmpty){
      _first = _last = entry;
      _last!.next = _first;
    }else{
      entry.next = _first;
      _first = entry;
      _last!.next = _first;
    }
      
    _size++;
  }

  void addLast(E entry) {
    if(isEmpty){
      _first = _last = entry;
      _last!.next = _first;
    }else{
      _last!.next = entry;
      _last = entry;
      _last!.next = _first;
    }
      
    _size++;
  }

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

  indexOf(E entry) {
    for (var c = _first, i = 0; c != null; c = c.next, i++)
      if (c == entry) 
        return i;

    return -1;
  }

  void reverse() {
    if(size <= 1)
      return;

    
  }

}