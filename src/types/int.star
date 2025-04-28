_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def int_type():
    def parse_int(v, context=_context.default_context()):
        typeof_v = type(v)
        if type(v) != "int":
            context.fail("Wanted int, got {}".format(typeof_v))

        return v

    return _type.create_type(parse_int)