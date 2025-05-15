_type = import_module("/src/common/type.star")

def __parse_struct(v, context):
    if type(v) != "struct":
        context.fail("Wanted struct, got {}".format(type(v)))

    return v

def __parse_struct_property(v, k, t, context):
    if k not in v:
        context.fail("Missing property {} in struct".format(k))
        

def create(properties, type_name="struct"):
    def __to_dict(v, context):
        return {k: getattr(v, k) for k in properties.keys()}

    def __to_struct(v, context):
        return struct(**v)

    pipeline = [__parse_struct, __to_dict]

    def __wrap(property_name, pipeline):
        def __property_pipeline(v, context):
            result = pipeline(getattr(v, property_name), context)





    for property_name, property_type in properties.items():
        kurtosistest.debug("Adding property {}: {}".format(property_name, property_type))





    return _type.create(
		name= type_name,
		pipelines=pipelines,
	)
