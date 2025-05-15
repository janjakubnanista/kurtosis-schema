_context = import_module("/src/common/context.star")

def test_context_default_context_push_pop(plan):
    context = _context.default_context()

    expect.fails(lambda: context.pop(), "invariant error: cannot pop from empty context stack")

    context.push(1)

    expect.eq(context.push("second"), "second")
    expect.eq(context.push({}), {})
    expect.eq(context.pop(), {})
    expect.eq(context.pop(), "second")

    expect.eq(context.push(2), 2)
    expect.eq(context.pop(), 2)
    
    expect.eq(context.pop(), 1)
    
    expect.fails(lambda: context.pop(), "invariant error: cannot pop from empty context stack")