_context = import_module("/src/common/context.star")

def transform(transformer):
    if type(transformer) != "function":
        fail("transform expects a function argument, got {}".format(transform))

    def __parse_transform(v, context = _context.default_context()):
        return transformer(v)

    return struct(
        __type = "transform",
        parse =  __parse_transform,
    )