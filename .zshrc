# override ls with eza
unalias ls 2>/dev/null || true
ls() {
  command eza --icons -1 -F --group-directories-first "$@"
}
