main = import_module("/main.star")

def _transform_multiply_by_two(v):
    return v * 2

def _transform_say_hey(v):
    return "hey {}".format(v)

def test_literal_type_basic(plan):
    constants = [
        0, 1, 1.0, "a", "", False, True, None, {}, [], struct(), struct(a="a")
    ]

    for constant in constants:
        expect.eq(main.literal_type(constant).parse(constant), constant)


def test_literal_type_transform(plan):
    expect.eq(main.literal_type(1).transform(_transform_say_hey).parse(1), "hey 1")
    expect.eq(main.literal_type(2).transform(_transform_multiply_by_two).parse(2), 4)


def test_literal_type_pipe(plan):
    literal_multiplied = main.literal_type(7).transform(_transform_multiply_by_two)
    int_greeted = main.int_type().transform(_transform_say_hey)

    expect.eq(main.int_type().pipe(literal_multiplied).pipe(int_greeted).parse(7), "hey 14")