_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def create(*types):
    if len(types) == 0:
        fail("union expects at least one type, got 0")

    return _type.create(
		name= "union of {}".format(", ".join([t.name for t in types])),
		pipelines=[ p for t in types for p in t.__pipelines ]
	)