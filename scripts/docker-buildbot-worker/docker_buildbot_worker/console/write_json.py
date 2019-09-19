import click

from ..core.database import Backend


@click.command()
@click.option(
    "--include-worktree/--no-include-worktree",
    help="Include images from the working tree",
)
def write_json(include_worktree):
    """Generate images.json."""
    backend = Backend.build(include_worktree=include_worktree)
    backend.save()
