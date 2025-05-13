_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def __parse_int(v, context=_context.default_context()):
	typeof_v = type(v)
	if type(v) != "int":
		context.fail("Wanted int, got {}".format(typeof_v))

	return v

def int_type():
	return _type.create_type(
		name= "int",
		pipelines=[[__parse_int]]
	)