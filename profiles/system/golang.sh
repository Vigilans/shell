# Keep GOPATH out of $HOME and put `go install` binaries beside the other
# user binaries.
export GOPATH="${GOPATH:-${XDG_DATA_HOME:-$HOME/.local/share}/go}"
export GOBIN="${GOBIN:-$HOME/.local/bin}"
