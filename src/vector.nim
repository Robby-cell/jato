type
  Vector*[T] = object
    data*: seq[T]
    size*: int

proc initVector*[T](): Vector[T] =
  Vector[T](data: newSeq[T](), size: 0)

proc pushBack*[T](v: var Vector[T], x: T) =
  v.data.add(x)
  v.size += 1

proc popBack*[T](v: var Vector[T]) =
  v.size -= 1
  v.data.setLen(v.size)

proc `[]`*[T](v: Vector[T], i: int): T =
  v.data[i]

proc `[]`*[T](v: var Vector[T], i: int): var T =
  v.data[i]

export Vector, initVector, pushBack, popBack, `[]`