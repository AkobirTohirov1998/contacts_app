import 'interfaces.dart';

class PredicateUtil<E> {
  Predicate<E> _predicate;

  PredicateUtil(Predicate<E> predicate) {
    this._predicate = predicate;
  }

  PredicateUtil<E> and(Predicate<E> predicate) {
    if (predicate == null) {
      return this;
    }

    return PredicateUtil<E>((element) => _predicate.call(element) && predicate.call(element));
  }

  PredicateUtil<E> or(Predicate<E> predicate) {
    if (predicate == null) {
      return this;
    }

    return PredicateUtil<E>((element) => _predicate.call(element) || predicate.call(element));
  }

  bool run(E element) {
    return this._predicate.call(element);
  }
}
