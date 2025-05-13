_int = import_module("/src/types/int.star")
_transform = import_module("/src/transform.star")
_schema = import_module("/src/schema.star")

def test_schema_simple(plan):
    schema = _schema.schema("int", _int.int_type())

    expect.eq(schema.parse(-1), -1)
    expect.eq(schema.parse(0), 0)
    expect.eq(schema.parse(1), 1)
    expect.eq(schema.parse(2), 2)

def test_schema_invalid_transform(plan):
    expect.fails(lambda: _schema.schema("int", _int.int_type(), "not a transform"), "schema 'int' received an invalid transform: not a transform")

def test_schema_transform(plan):
    schema = _schema.schema("int", _int.int_type(), _transform.transform(lambda x: x * 2))
    wrapped_schema = _schema.schema("wrapped int", schema, _transform.transform(lambda x: x * 2))

    expect.eq(wrapped_schema.parse(-1), -4)
    expect.eq(wrapped_schema.parse(0), 0)
    expect.eq(wrapped_schema.parse(1), 4)
    expect.eq(wrapped_schema.parse(2), 8)