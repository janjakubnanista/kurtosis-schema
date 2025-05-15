def _context_stack_mixin():
    stack = []

    def _push(v):
        stack.append(v)

        return v

    def _pop():
        if len(stack) == 0:
            fail("invariant error: cannot pop from empty context stack")

        return stack.pop()

    return {
        "push": _push,
        "pop": _pop,
    }

def default_context():
    return struct(
        fail=fail,
        **_context_stack_mixin(),
    )

def short_term_memory_context():
    failures = [None]

    def _fail(message):
        failures[0] = message

    def _failed():
        return failures[0] != None

    def _failure():
        return failures[0]
            

    return struct(
        fail=_fail,
        failure=_failure,
        failed=_failed,
        **_context_stack_mixin(),
    )

def failure_accumulator_context():
    failures = []

    def _fail(message):
        failures.append(message)

    def _failures():
        return failures

    def _failed():
        return len(failures) > 0

    return struct(
        fail=_fail,
        failures=_failures,
        failed=_failed,
        **_context_stack_mixin(),
    )