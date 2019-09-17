def header(text, level):
    prefix = "#" * level
    return f"{prefix} {text}"


def pre(text):
    return f"`{text}`"


def row(args):
    return "|".join(f" {arg} " for arg in args).join("||")


def table(rows):
    separator = ["---" for cell in rows[0]]
    rows = [rows[0], separator, *rows[1:]]
    widths = list(map(max, zip(*(map(len, row_) for row_ in rows))))

    for row_ in rows:
        yield row(cell.ljust(width) for cell, width in zip(row_, widths))


def anchor(name):
    slug = "".join(
        (c if c.isalnum() or c == "_" else "-") for c in name.lower() if c not in ".()"
    )
    return f"#{slug}"


def link(text, url=None):
    if url is None:
        url = anchor(text)
    return f"[{text}]({url})"


def item(text):
    return f"- {text}"
