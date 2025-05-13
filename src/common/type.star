_context = import_module("./context.star")

def _append_pipelines(existing_pipelines, new_pipelines):
    return [ e + n for e in existing_pipelines for n in new_pipelines ]

def _contextualize(f):
    return lambda v,context: f(v)

def _pipe(v, pipelines, context):
    for pipeline in pipelines:
        current = v
        pipeline_context = _context.short_term_memory_context()

        for parser in pipeline:
            current = parser(current, pipeline_context)
            
            if pipeline_context.failed():
                break
        
        if not pipeline_context.failed():
            return current

    # FIXME
    context.fail("Failed to parse value: {}".format(v))

def create_type(name, pipelines):
    transform = lambda transformer, name=name: create_type(name=name, pipelines=_append_pipelines(pipelines, [[_contextualize(transformer)]]))

    pipe = lambda schema, name=name: create_type(name=name, pipelines=_append_pipelines(pipelines, schema.__pipelines))

    parse = lambda v, context=_context.default_context(): _pipe(v, pipelines, context)

    return struct(
        __name=name,
        __pipelines=pipelines,
        parse=parse,
        transform=transform,
        pipe=pipe,
    )