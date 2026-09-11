# shell

A modular shell framework with a ready-to-use toolchain for everyday development.
Organize your environment, aliases, and shell customizations as small scripts,
share configuration across shells, and keep machine-specific additions local.

## Supported shells

- **Zsh** — CLI tools, runtimes, and plugins managed with zinit. Includes fzf
  key bindings, fzf-tab completion previews, syntax highlighting, and
  autosuggestions. Prompt choices include a customized Pure, Starship, and
  `90210`.
- **Bash** — A traditional setup with Readline history search, system
  bash-completion, and an oh-my-bash-based `90210` prompt. Can also use CLI
  tools installed by zinit.

## Install

On Linux or macOS, back up your existing shell startup files, then run:

```bash
git clone https://github.com/Vigilans/shell.git ~/shell
bash ~/shell/bootstrap.sh
```

The installer links the checkout at `~/.config/shell` and offers to make zsh
your login shell. If it reports skipped startup files, merge the corresponding
files from [dotfiles/](dotfiles/) with your existing configuration. Start a new
shell after installation.

To update the managed tools, plugins, and completions:

```bash
bash ~/.config/shell/bootstrap.sh upgrade
```

## Features

The included zsh setup uses [zinit](https://github.com/zdharma-continuum/zinit)
to manage tools and plugins:

- **Modern CLI tools** for browsing files, searching code, and reading diffs,
  including `eza`, `bat`, `ripgrep`, and `delta`.
- **Development tools** for working with structured data and repositories,
  such as `jq`, `gh`, and `lazygit`.
- **Python and Node.js**, managed with `uv` and `mise`. The bundled runtimes
  serve as fallbacks when another installation is not already on `PATH`.
- **Command completion**, generated from tools and refreshed on upgrade.
  Integrations also cover existing tools such as Docker and kubectl.
- **Interactive editing** with syntax highlighting, command suggestions,
  history search, and fuzzy completion menus with previews.

The tools work together in the shell: directory aliases use eza, and completion
previews show file contents with bat and Git diffs with delta.

## Customize

Configuration lives under `~/.config/shell`. Add or edit scripts in the directory
for the part of your setup you want to change:

| Directory | Purpose |
| --- | --- |
| [profiles/](profiles/) | Environment variables and toolchain paths |
| [aliases/](aliases/) | Shared command aliases |
| [functions/](functions/) | Shell helper functions |
| [commands/](commands/) | Your own executables, added to `PATH` |
| [.initrc.d/](.initrc.d/) | Shared interactive settings |
| [.bashrc.d/](.bashrc.d/) | Bash options, completion, and themes |
| [.zshrc.d/](.zshrc.d/) | Zsh options, tools, plugins, completion, and themes |

Shared scripts use `.sh`, and zsh-specific scripts use `.zsh`. Scripts within
each configuration directory load in filename order.

### Local settings

Put machine-specific environment settings in `profiles/local/*.sh` and local
executables in `commands/local/`. Both directories are ignored by Git.
Local profiles load before the bundled system and user profiles, so they can
supply settings such as `CONDA_HOME` or `CARGO_HOME` for the toolchain setup.

### Tools and interaction

Edit [the zinit configuration](.zshrc.d/01-zinit.zsh) to change the selection of
tools and plugins. [Completion previews](.zshrc.d/03-fzf.zsh) and
[key bindings](.zshrc.d/99-keybinding.zsh) have their own configuration files.

### Prompt

Set `SHELL_THEME` to choose a prompt. Bash includes `90210` and `git-bash`, the
Git for Windows prompt with a clock, which is the default on Windows. Zsh offers
`90210`, a customized `pure`, and `starship`.

## License

[MIT](LICENSE). The following files are vendored from other MIT-licensed
projects and keep their notices in the file header:

- [.bashrc.d/vendors/theme-base.sh](.bashrc.d/vendors/theme-base.sh),
  [.bashrc.d/vendors/theme-colours.sh](.bashrc.d/vendors/theme-colours.sh),
  [.bashrc.d/vendors/themes/90210.theme.sh](.bashrc.d/vendors/themes/90210.theme.sh),
  [aliases/grep.sh](aliases/grep.sh) from
  [oh-my-bash](https://github.com/ohmybash/oh-my-bash) and
  [Bash-it](https://github.com/Bash-it/bash-it).
- The prompt render override in
  [.zshrc.d/themes/pure.zinit.zsh-theme](.zshrc.d/themes/pure.zinit.zsh-theme) from
  [pure](https://github.com/sindresorhus/pure).
