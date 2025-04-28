def create_type(parse):
    transform = lambda transformer: create_type(lambda v: transformer(parse(v)))

    pipe = lambda schema: transform(schema.parse)

    return struct(
        parse=parse,
        transform=transform,
        pipe=pipe,
    )