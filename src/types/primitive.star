def create_parse(typeof):
    def parse_primitive(v, context):
        typeof_v = type(v)
        if typeof_v != typeof:
            context.fail("Wanted {}, got {}".format(typeof, typeof_v))

        return v

    return parse_primitive