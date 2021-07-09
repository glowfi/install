## PATH
set PATH ~/node-v16.4.1-linux-x64/bin/ $PATH                                    # sets NODEJS path
set PATH ~/.local/bin/ $PATH                                                    # sets Universal path

### EXPORT
set fish_greeting                                 # Supresses fish's greeting message
set TERM "xterm-256color"                         # Sets the terminal type

### ALIASES

# Changing ls to exa
alias ls='exa -l --color=always --group-directories-first'

# Changing cat to bat
alias cat='bat'

# Changing grep to ripgrep
alias grep='rg'

# Changing find to fd
alias find='fd'

# Synchronize mirrorlist
alias mirru='sudo rm -rf /var/lib/pacman/db.lck
sudo reflector --verbose --country "Germany" -l 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyy'

# Cleanup
alias cleanup='yes | sudo pacman -Sc
yes | yay -Sc
printf "Cleaned Unused Pacakges!\n"
rm -rf ~/.cache/*
printf "Cleaned Cache!\n"
sudo pacman -Rns (pacman -Qtdq)  2> /dev/null
yes | printf "Cleaned Orphans!"'

# Fetchmaster alias
alias fm="cd ~/.local/bin/fm;python ./fetchmaster.py;cd"

# Default Editor
export EDITOR=nvim

function searchFiles
  du -a ~/.config/* ~/cdx/* ~/main/* | awk '{print $2}' |fzf --preview 'bat --style numbers,changes --color=always {}'|read -t args
  if test -z "$args"
    echo "Exited from searching files!"
  else
    nvim $args
  end
end

function searchContents
  rg . | fzf | awk -F':' '{ print $1 }'|read -t args
  if test -z "$args"
    echo "Exited from searching file contents!"
  else
    nvim $args
  end
end

# Find file and open in editor
alias sf="searchFiles"

# Find contents inside of the file and open in the editor
alias sc="searchContents"


### GIT FUNCTIONS


function git_is_repo -d "Check if directory is a repository"
  test -d .git
  or begin
    set -l info (command git rev-parse --git-dir --is-bare-repository 2>/dev/null)
    and test $info[2] = false
  end
end


function git_ahead -a ahead behind diverged none
  not git_is_repo; and return

  set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" 2> /dev/null)

  switch "$commit_count"
  case ""
    # no upstream
  case "0"\t"0"
    test -n "$none"; and echo "$none"; or echo ""
  case "*"\t"0"
    test -n "$behind"; and echo "$behind"; or echo "-"
  case "0"\t"*"
    test -n "$ahead"; and echo "$ahead"; or echo "+"
  case "*"
    test -n "$diverged"; and echo "$diverged"; or echo "±"
  end
end


function git_branch_name -d "Get current branch name"
  git_is_repo; and begin
    command git symbolic-ref --short HEAD 2> /dev/null;
      or command git show-ref --head -s --abbrev | head -n1 2> /dev/null
  end
end


function git_is_dirty -d "Check if there are changes to tracked files"
  git_is_worktree; and not command git diff --no-ext-diff --quiet --exit-code
end


function git_is_staged -d "Check if repo has staged changes"
  git_is_repo; and begin
    not command git diff --cached --no-ext-diff --quiet --exit-code
  end
end


function git_is_stashed -d "Check if repo has stashed contents"
  git_is_repo; and begin
    command git rev-parse --verify --quiet refs/stash >/dev/null
  end
end


function git_is_touched -d "Check if repo has any changes"
  git_is_worktree; and begin
    # The first checks for staged changes, the second for unstaged ones.
    # We put them in this order because checking staged changes is *fast*.
    not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
    or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
  end
end


function git_is_worktree -d "Check if directory is inside the worktree of a repository"
  git_is_repo
  and test (command git rev-parse --is-inside-git-dir) = false
end


function git_untracked -d "Print list of untracked files"
  git_is_worktree; and begin
    command git ls-files --other --exclude-standard
  end
end

# OMF BANG-BANG FUNCTION


function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end


function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# BINDING BANG-BANG FUNCTION


bind ! __history_previous_command
bind '$' __history_previous_command_arguments

# set up the same key bindings for insert mode if using fish_vi_key_bindings
if test "$fish_key_bindings" = 'fish_vi_key_bindings'
    bind --mode insert ! __history_previous_command
    bind --mode insert '$' __history_previous_command_arguments
end

## THEME


function fish_prompt
    set -l last_command_status $status

    set_color red --bold
    printf "["
    set_color blue
    printf "%s" "$USER"
    set_color green
    printf "@"
    set_color yellow
    printf "%s" "$hostname "
    set_color C7ECEC
    printf (pwd | sed "s|^$HOME|~|")
    set_color red --bold
    printf "] "
    set_color ffc04d
    printf "🠮 "

    set -l normal_color (set_color normal)
    set -l branch_color (set_color yellow)
    set -l meta_color (set_color brgreen)
    set -l symbol_color (set_color blue -o)
    set -l error_color (set_color red -o)
    set -l purple (set_color -o purple)

    if git_is_repo
        echo -n -s $branch_color (git_branch_name) $normal_color
        set -l git_meta ""
        if test (command git ls-files --others --exclude-standard | wc -w 2> /dev/null) -gt 0
            set git_meta "$symbol_color?"
        end
        if test (command git rev-list --walk-reflogs --count refs/stash 2> /dev/null)
            set git_meta "$git_meta\$"
        end
        if git_is_touched
            git_is_dirty && set git_meta "$error_color✘"
            git_is_staged && set git_meta "$git_meta●"
        end
        set -l commit_count (command git rev-list --count --left-right (git remote)/(git_branch_name)"...HEAD" 2> /dev/null)
        if test $commit_count
            set -l behind (echo $commit_count | cut -f 1)
            set -l ahead (echo $commit_count | cut -f 2)
            if test $behind -gt 0
                set git_meta "$purple🠋"
            end
            if test $ahead -gt 0
                set git_meta "$purple🠉"
            end
        end
        if test $git_meta
            echo -n -s $meta_color " " $git_meta " " $normal_color
        else
            echo -n -s ""
        end
    end

    if test $last_command_status -eq 0
        echo -n -s $symbol_color $symbol " " $normal_color
    else
        echo -n -s $error_color $symbol " " $normal_color
    end
end


function fish_right_prompt

    set -l S (math $CMD_DURATION/1000)
    set -l M (math $S/60)

    echo -n -s " "
    if test $M -gt 1
        echo -n -s $M m
    else if test $S -gt 1
        echo -n -s $S s
    else
        echo -n -s $CMD_DURATION ms
    end
    set_color normal
end
