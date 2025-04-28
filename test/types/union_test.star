main = import_module("/main.star")

def _transform_multiply_by_two(v):
    return v * 2

def _transform_say_hey(v):
    return "hey {}".format(v)

def test_union_type_basic(plan):
    expect.eq(main.union_type(main.int_type()).parse(1), 1)
    
    expect.eq(main.union_type(main.int_type(), main.int_type().transform(_transform_multiply_by_two)).parse(1), 1)
    expect.eq(main.union_type(main.int_type().transform(_transform_multiply_by_two), main.int_type()).parse(1), 2)

def test_union_type_transform(plan):
    expect.eq(main.union_type(main.int_type()).transform(_transform_say_hey).parse(1), "hey 1")


def test_union_type_pipe(plan):
    int_multiplied = main.int_type().transform(_transform_multiply_by_two)
    int_greeted = main.int_type().transform(_transform_say_hey)

    expect.eq(main.union_type(int_multiplied).pipe(int_greeted).parse(1), "hey 2")