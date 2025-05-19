def left(error):
    return struct(
        __type="left",
        value=error,
    )

def right(value):
    return struct(
        __type="right",
        value=value,
    )

def flat_map(fn):
    def _flat_map(either):
        if either.__type == "left":
            return either
        else:
            return fn(either.value)

    return _flat_map

def map(fn):
    def _map(either):
        if either.__type == "left":
            return either
        else:
            return right(fn(either.value))

    return _map