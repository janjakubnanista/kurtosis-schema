main = import_module("/main.star")

def _transform_multiply_by_two(v):
    return v * 2

def _transform_say_hey(v):
    return "hey {}".format(v)

def test_optional_type_basic(plan):
    types = [
        main.int_type(),
        main.literal_type(1),
        main.union_type(main.int_type()),
    ]

    for t in types:
        expect.eq(main.optional_type(t).parse(None), None)

    expect.eq(main.optional_type(main.int_type()).parse(1), 1)
    expect.eq(main.optional_type(main.int_type()).parse(-1), -1)
    expect.eq(main.optional_type(main.int_type()).parse(0), 0)
    expect.eq(main.optional_type(main.int_type()).parse(1.0), 1)
    expect.eq(main.optional_type(main.literal_type("1")).parse("1"), "1")


def test_optional_type_transform(plan):
    expect.eq(main.optional_type(main.int_type()).transform(_transform_say_hey).parse(None), "hey None")
    expect.eq(main.optional_type(main.int_type()).transform(_transform_say_hey).parse(1), "hey 1")


def test_optional_type_pipe(plan):
    literal_multiplied = main.literal_type(7).transform(_transform_multiply_by_two)
    int_greeted = main.int_type().transform(_transform_say_hey)

    expect.eq(main.optional_type(literal_multiplied).pipe(int_greeted).parse(7), "hey 14")