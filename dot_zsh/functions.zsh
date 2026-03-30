# Count files matching a glob pattern
countf() {
  printf '%s\n' $~1 | wc -l
}

# Side-by-side diff with diff-so-fancy
fdiff() {
  diff -u "$1" "$2" | diff-so-fancy
}

# Run claude bugfix skill (-i for interactive mode)
bugfix() {
  claude --allowedTools "Edit,MultiEdit,Write,Bash(*)" -- "/bugfix $1"
}

# Run claude feat-request skill (-i for interactive mode)
feature() {
  claude --allowedTools "Edit,MultiEdit,Write,Bash(*)" -- "/feature $1"
}

tarf() {
  local pattern output pigz_threads=8

  # Parse options
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -p)
        pigz_threads="$2"
        shift 2
        ;;
      *)
        if [[ -z "$pattern" ]]; then
          pattern="$1"
        elif [[ -z "$output" ]]; then
          output="$1"
        else
          echo "Usage: tarf [-p threads] <glob_pattern> <output.tar.gz>"
          return 1
        fi
        shift
        ;;
    esac
  done

  if [[ -z "$pattern" || -z "$output" ]]; then
    echo "Usage: tarf [-p threads] <glob_pattern> <output.tar.gz>"
    return 1
  fi

  local files
  files=(${~pattern})

  if [[ ${#files} -eq 0 ]]; then
    echo "Error: no files matched pattern '$pattern'"
    return 1
  fi

  echo "Found ${#files} files. Archiving to $output (pigz threads: $pigz_threads)..."

  printf '%s\n' $files | tar -cf - --files-from=- | pv | pigz -p "$pigz_threads" > "$output"

  if [[ $? -ne 0 ]]; then
    echo "Error: tar failed. Aborting — input files untouched."
    return 1
  fi

  echo "\nVerifying archive integrity..."
  local archived_count
  archived_count=$(tar -tzf "$output" 2>/dev/null | wc -l | tr -d ' ')

  if [[ $? -ne 0 ]]; then
    echo "Error: archive appears corrupt. Aborting — input files untouched."
    return 1
  fi

  if [[ "$archived_count" -ne "${#files}" ]]; then
    echo "Error: expected ${#files} files in archive, found $archived_count. Aborting — input files untouched."
    return 1
  fi

  echo "Verification passed: $archived_count/$archived_count files confirmed in archive."
  echo "Archive size: $(du -sh "$output" | awk '{print $1}')"

  echo "\nDelete ${#files} input files matching '$pattern'? [y/N] "
  read -r confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    printf '%s\n' $files | xargs rm
    if [[ $? -eq 0 ]]; then
      echo "Deleted ${#files} input files."
    else
      echo "Warning: some files may not have been deleted."
      return 1
    fi
  else
    echo "Skipping deletion. Input files untouched."
  fi
}