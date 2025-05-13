_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def __parse_literal(v, literal, context=_context.default_context()):
	if v != literal:
		context.fail("Wanted {}, got {}".format(literal, v))

	return v

def literal_type(value):
	___parse_literal = lambda v, context=_context.default_context(): __parse_literal(v, value, context)

	return _type.create_type(
		name= "literal {}".format(value),
		pipelines=[[___parse_literal]]
	)