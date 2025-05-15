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
        for k in properties.keys():
            if not hasattr(v, k):
                context.fail("Missing property {} in struct".format(k))

                return {}

        return {k: getattr(v, k) for k in properties.keys()}

    def __push_to_stack(v, context):
        return context.push(v)

    def __pop_from_stack(v, context):
        return context.pop()

    def __to_struct(v, context):
        return struct(**v)

    pipelines = [[__parse_struct, __to_dict, __push_to_stack]]

    for property_name, property_type in properties.items():
        def __get_property(v, context):
            if property_name not in v:
                fail("invariant error: property {} not in struct".format(property_name))
            else:
                return v[property_name]

        def __set_property(v, context):
            d = __pop_from_stack(v, context)

            d[property_name] = v

            return __push_to_stack(d, context)

        pipelines = _type.append_pipelines(pipelines, [[__get_property]])
        pipelines = _type.append_pipelines(pipelines, _type.get_pipelines(property_type))
        pipelines = _type.append_pipelines(pipelines, [[__set_property]])

    pipelines = _type.append_pipelines(pipelines, [[__pop_from_stack, __to_struct]])

    return _type.create(
		name= type_name,
		pipelines=pipelines,
	)
