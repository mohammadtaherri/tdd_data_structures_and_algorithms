part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry>{

  bool get isEmpty => _size == 0;
  int get size => _size;
  int _size = 0;

  E? get first => _first;
  E? _first;
  E? get last => _last;
  E? _last;

  void addFirst(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      entry.next = _last;
      _first = entry;
    }
      

    _size++;
  }

  void addLast(E entry) {
    if(isEmpty)
      _first = _last = entry;
    else{
      _first!.next = entry;
      _last = entry;
    }
      
      
    _size++;
  }

  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    _first = _last = null;

    _size = 0;
  }

  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    _first = _last = null;

    _size = 0;
  }

  int indexOf(E entry) {
    E? current = _first;
    int index = 0;

    if(current != null)
      if(current == entry)
        return index;
    
    return -1;
  }
}

class LinkedListEntry{
  var next;
}