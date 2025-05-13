_context = import_module("/src/common/context.star")

def schema(name, *transforms):
    if len(transforms) == 0:
        fail("schema '{}' requires at least one transformation, got 0".format(name))

    flattened_transforms = []
    for t in transforms:
        if __is_schema(t):
            flattened_transforms = flattened_transforms + t.__transforms
        elif __is_type(t):
            flattened_transforms.append(t)
        else:
            fail("schema '{}' received an invalid transform: {}".format(name, t))

    def __parse_schema(v, context=_context.default_context()):
        current = v

        for t in flattened_transforms:
            current = t.parse(current, context)

        return current


    return struct(
        __type= "schema",
        __transforms= flattened_transforms,
        parse= __parse_schema,
    )

def __is_schema(t):
    if not __is_type(t):
        return False

    if t.__type != "schema":
        return False

    if type(getattr(t, "__transforms", None)) != "list":
        return False

    return True

def __is_type(t):
    if type(t) != "struct":
        return False

    if type(getattr(t, "__type", None)) != "string":
        return False

    if type(getattr(t, "parse", None)) != "function":
        return False

    return True

    