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
    isEmpty 
      ? _initFirstAndLastTo(entry) 
      : _changeFirstTo(entry);
    updateLinks(previousEntry: _first, nextEntry: oldFirst);
    _incrementSizeByOne();
  }

  @override
  void addLast(E entry) {
    var oldLast = _last;
    isEmpty 
      ? _initFirstAndLastTo(entry) 
      : _changeLastTo(entry);
    updateLinks(previousEntry: oldLast, nextEntry: _last);
    _incrementSizeByOne();
  }

  @override
  void removeFirst() {
    if(isEmpty)
      throw IllegalState();

    var oldFirst = _first;
    _sizeIsOne
      ? _clearFirstAndLast()
      : _changeFirstTo(first!.next);
    updateLinks(previousEntry: null, nextEntry: _first);
    unlinke(oldFirst);
    _decrementSizeByOne();
  }

  @override
  void removeLast() {
    if(isEmpty)
      throw IllegalState();

    var oldLast = _last;
    _sizeIsOne
      ? _clearFirstAndLast()
      : _changeLastTo(nodeBefore(last!)!);
    updateLinks(previousEntry: _last, nextEntry: null);
    unlinke(oldLast);
    _decrementSizeByOne();
  }

  void _initFirstAndLastTo(E entry) {
    _first = _last = entry;
  }

  void _changeFirstTo(entry) {
    _first = entry;
  }

  void _changeLastTo(E entry) {
    _last = entry;
  }

  void _clearFirstAndLast() {
    _first = _last = null;
  }

  @protected
  E? nodeBefore(E node) {
    for (var current = _first; current != null; current = current.next)
      if (current.next == node) return current;

    return null;
  }

  @protected
  @mustCallSuper
  void updateLinks({E? previousEntry, E? nextEntry}){
    previousEntry?.next = nextEntry;
  }

  @protected
  @mustCallSuper
  void unlinke(E? entry){
    entry?.next = null;
  }

  bool get _sizeIsOne => _first == _last;

  void _incrementSizeByOne() => _size++;
  void _decrementSizeByOne() => _size--;
}