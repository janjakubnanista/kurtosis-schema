_union = import_module("./union.star")

def optional_type(original_type):
	return _type.create_type(
		name= "optional",
		pipelines=[[__parse_int]]
	)