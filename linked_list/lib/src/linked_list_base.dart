part of linked_list;

abstract class _LinkedListBase<E extends LinkedListEntry<E>> implements LinkedList<E>{

  @override
  get isEmpty => _size == 0;

  @override
  get size => _size;
  int _size = 0;

  @override
  get first => _first;
  E? _first;

  @override
  get last => _last;
  E? _last;

  @override
  void addFirst(E entry) {
    var oldFirst = _first;

    if(isEmpty)
      _first = _last = entry;
    else
      _first = entry;
    
    updateLinks(previousEntry: _first, nextEntry: oldFirst);

    _size++;
  }

  @override
  void addLast(E entry) {
    var oldLast = _last;

    if(isEmpty)
      _first = _last = entry;
    else
      _last = entry;

    updateLinks(previousEntry: oldLast, nextEntry: _last);

    _size++;
  }

  @override
  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    var oldFirst = _first;

    if(_first == _last)
      _first = _last = null;
    else
      _first = first!.next;
    
    updateLinks(previousEntry: null, nextEntry: _first);
    unlinke(oldFirst);
    
    _size--;
  }

  @override
  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    var oldLast = _last;

    if(_first == _last)
      _first = _last = null;
    else
      _last = nodeBefore(_last!);
    
    updateLinks(previousEntry: _last, nextEntry: null);
    unlinke(oldLast);

    _size--;
  }

  E? nodeBefore(E node) {
    for (var current = _first; current != null; current = current.next)
      if (current.next == node) return current;

    return null;
  }

  void updateLinks({E? previousEntry, E? nextEntry}){
    previousEntry?.next = nextEntry;
  }

  void unlinke(E? entry){
    entry?.next = null;
  }
}