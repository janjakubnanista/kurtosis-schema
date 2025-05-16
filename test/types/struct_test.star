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
    expect.eq(main.struct_type({
        "key": main.int_type(),
        "other_key": main.literal_type(7)
    }).parse(struct(key=1, other_key=7)), struct(key=1, other_key=7))

    expect.fails(lambda: main.struct_type({
        "key": main.int_type(),
        "other_key": main.literal_type(7)
    }).parse(struct(key=1, other_key="a")), "Expected 'other_key' to be of type 'literal(7)', but got 'literal(a)'")
    expect.fails(lambda: main.struct_type({
        "key": main.int_type(),
        "other_key": main.literal_type(7),
        "yet_another_key": main.int_type()
    }).parse(struct(key=1)), "Missing property other_key in struct")