_int_module = import_module("/src/types/int.star")
_literal_module = import_module("/src/types/literal.star")
_optional_module = import_module("/src/types/optional.star")
_union_module = import_module("/src/types/union.star")

int_type = _int_module.create
literal_type = _literal_module.create
optional_type = _optional_module.create
union_type = _union_module.create

