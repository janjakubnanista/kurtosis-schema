_context = import_module("/src/common/context.star")
_type = import_module("/src/common/type.star")

def union_type(*args):
    if len(args) == 0:
        fail("union_type requires at least one schema as an argument")

    def parse_union(v, context=_context.default_context()):
        _union_context = _context.failure_accumulator_context()

        for t in args:
            _t_context = _context.short_term_memory_context()

            parsed = t.parse(v)

            if _t_context.failed():
                _union_context.fail(_t_context.failure())
            else:
                return parsed

        context.fail("No union member type matches {}. Member errors:\n\n{}".format(v, "\n".join(_union_context.failures())))

    return _type.create_type(parse_union)