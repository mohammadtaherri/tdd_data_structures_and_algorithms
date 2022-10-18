part of linked_list;

class SinglyLinkedList<E extends LinkedListEntry> {

  get isEmpty => _size == 0;
  get size => _size;
  int _size = 0;

  E? get first => _first;
  E? _first;
  E? get last => _last;
  E? _last;

  void addFirst(E entry) {
    _first = _last = entry;
    _size++;
  }
}

class LinkedListEntry{
  
}


