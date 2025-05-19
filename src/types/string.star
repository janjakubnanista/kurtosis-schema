_type = import_module("/src/common/type.star")
_primitive = import_module("./primitive.star")

_parse_string = _primitive.create_parse("string")

def create():
	return _type.create(
		name= "string",
		pipelines=[[_parse_string]]
	)