# Ansii color codes
BEGIN="\e["
RED="31"
GREEN="32"
RESET="0"
BOLD="1"
FAINT="2"
ITALIC="3"
END="m"
BOLDGREEN="${BEGIN}${BOLD};${GREEN}${END}"
ENDFORMAT="${BEGIN}${RESET}${END}"

print_pwd() {
  pwd | sed "s|$HOME|~|g"
}

print_git_branch() {
  local GIT_ORIGIN=$(git remote get-url origin 2>/dev/null || echo "No origin")
  local GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ "$GIT_BRANCH" != "" ]; then
    echo -e "${BEGIN}${RED}${END}${GIT_ORIGIN}: (${GIT_BRANCH})${ENDFORMAT}"
  else
    echo -e "${BEGIN}${FAINT}${END}(Not a git repository)${ENDFORMAT}"
  fi
}

# Add formatting to terminal prefixing
export PS1="\n\$(print_git_branch)\n${BOLDGREEN}\u${ENDFORMAT}@ \$(print_pwd): "

# Change tab title
PROMPT_COMMAND='echo -en "\033]0;$(whoami)@$(print_pwd)\a"'
