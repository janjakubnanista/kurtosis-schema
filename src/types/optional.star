_literal = import_module("./literal.star")
_union = import_module("./union.star")

def optional_type(original_type):
	return _union.union_type(
        original_type,
        _literal.literal_type(None)
    )