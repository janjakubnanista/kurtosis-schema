_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def __parse_literal(v, literal, context=_context.default_context()):
	kurtosistest.debug("Parsing literal {}: {}".format(literal, v))
	if v != literal:
		kurtosistest.debug("Failed to parse literal {}: {}".format(literal, v))
		context.fail("Wanted {}, got {}".format(literal, v))

	return v

def create(value):
	def ___parse_literal(v, context=_context.default_context()):
		return __parse_literal(v=v, literal=value, context=context)

	return _type.create(
		name= "literal {}".format(value),
		pipelines=[[___parse_literal]]
	)