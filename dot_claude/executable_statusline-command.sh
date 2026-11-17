#!/bin/bash
# Catppuccin-themed status line with emojis
# Catppuccin Mocha color palette (pastel colors)

# Read JSON input
input=$(cat)

# Extract values from JSON
dir=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')

# Catppuccin Mocha colors (RGB)
MAUVE="203;166;247"      # Soft purple
PEACH="250;179;135"      # Soft orange
SKY="137;220;235"        # Soft cyan
LAVENDER="180;190;254"   # Light purple
PINK="245;194;231"       # Soft pink
GREEN="166;227;161"      # Soft green
YELLOW="249;226;175"     # Soft yellow
MAROON="235;160;172"     # Soft red
TEAL="148;226;213"       # Soft teal
SAPPHIRE="116;199;236"   # Soft blue

# Helper function for colored text
color() {
    printf "\033[38;2;%sm%s\033[0m" "$1" "$2"
}

# Display shortened directory
disp="${dir/#$HOME/~}"

# Git information with emoji
git_info=""
if git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
    branch=$(git -C "$dir" branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        # Check if there are uncommitted changes
        if git -C "$dir" diff-index --quiet HEAD -- 2>/dev/null; then
            # Clean repo
            git_emoji="✨"
            git_info=" $(color "$TEAL" "$git_emoji ($branch)")"
        else
            # Dirty repo
            git_emoji="📝"
            git_info=" $(color "$PEACH" "$git_emoji ($branch)")"
        fi
    fi
fi

# Context window usage with emoji indicators
ctx=""
usage=$(echo "$input" | jq '.context_window.current_usage')
if [ "$usage" != "null" ]; then
    curr=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
    size=$(echo "$input" | jq '.context_window.context_window_size')

    if [ "$curr" != "null" ] && [ "$size" != "null" ] && [ "$size" -gt 0 ]; then
        pct=$((curr * 100 / size))

        # Choose emoji based on context usage level
        if [ "$pct" -lt 25 ]; then
            ctx_emoji="🟢"
            ctx_color="$GREEN"
        elif [ "$pct" -lt 50 ]; then
            ctx_emoji="🟡"
            ctx_color="$YELLOW"
        elif [ "$pct" -lt 75 ]; then
            ctx_emoji="🟠"
            ctx_color="$PEACH"
        else
            ctx_emoji="🔴"
            ctx_color="$MAROON"
        fi

        ctx=" $(color "$ctx_color" "$ctx_emoji ${pct}%")"
    fi
fi

# Output style indicator with emoji
style_info=""
if [ "$output_style" != "default" ]; then
    style_info=" $(color "$LAVENDER" "📖 $output_style")"
fi

# Model indicator with brain emoji
model_info="$(color "$MAUVE" "🧠 $model")"

# User and host with home emoji
user_host="$(color "$SKY" "🏠 $(whoami)@$(scutil --get ComputerName 2>/dev/null || hostname -s)")"

# Directory with folder emoji
dir_info="$(color "$SAPPHIRE" "📂 $disp")"

# Assemble the final status line
printf "%s %s%s%s%s %s" "$user_host" "$dir_info" "$git_info" "$ctx" "$style_info" "$model_info"
