main = import_module("/main.star")

def _transform_multiply_by_two(v):
    return v * 2

def _transform_say_hey(v):
    return "hey {}".format(v)

def test_struct_type_basic(plan):
    expect.eq(main.struct_type({}).parse(struct()), struct())
    expect.eq(main.struct_type({
        "key": main.int_type()
    }).parse(struct(key=1)), struct(key=1))