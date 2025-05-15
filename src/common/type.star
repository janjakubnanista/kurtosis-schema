_context = import_module("./context.star")

def _contextualize(f):
    return lambda v,context: f(v)

def _pipe(v, pipelines, context):
    pipelines_context = _context.failure_accumulator_context()

    for pipeline in pipelines:
        pipeline_context = _context.short_term_memory_context()

        current = v
        for parser in pipeline:
            current = parser(current, pipeline_context)
            
            if pipeline_context.failed():
                pipelines_context.fail(pipeline_context.failure())
                break
        
        if not pipeline_context.failed():
            return current

    context.fail("Failed to parse value: {}".format("; ".join(pipelines_context.failures())))

def create(name, pipelines):
    transform = lambda transformer, name=name: create(name=name, pipelines=append_pipelines(pipelines, [[_contextualize(transformer)]]))

    pipe = lambda t, name=name: create(name=name, pipelines=append_pipelines(pipelines, t.__pipelines))

    parse = lambda v, context=_context.default_context(): _pipe(v, pipelines, context)

    return struct(
        __pipelines=pipelines,
        name=name,
        parse=parse,
        transform=transform,
        pipe=pipe,
    )

def append_pipelines(existing_pipelines, new_pipelines):
    return [ e + n for e in existing_pipelines for n in new_pipelines ]

def rename(t, name):
    return create(name=name, pipelines=t.__pipelines)

def get_pipelines(t):
    return t.__pipelines