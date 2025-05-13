_literal = import_module("./literal.star")
_union = import_module("./union.star")
_type = import_module("/src/common/type.star")

def create(t):
	return _type.rename(name="optional {}".format(t.name), t=_union.create(
        t,
        _literal.create(None)
    ))