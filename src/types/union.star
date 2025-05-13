_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def union_type(*types):
    if len(types) == 0:
        fail("union expects at least one type, got 0")

    return _type.create_type(
		name= "union",
		pipelines=[ p for t in types for p in t.__pipelines ]
	)