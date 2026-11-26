def clean_string(value):
    if not isinstance(value, str):
        return ""
    return value.strip().lower()


def parse_int(value, default=0):
    try:
        return int(value)
    except (ValueError, TypeError):
        return default


def is_valid_row(row):
    return bool(row.get("id")) and bool(row.get("name"))
