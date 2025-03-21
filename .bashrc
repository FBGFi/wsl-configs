# Force colorized terminal
TERM=xterm-256color

# Ansii color codes
BEGIN="\[\e["
RED="31"
GREEN="32"
BLUE="34"
RESET="0"
BOLD="1"
FAINT="2"
ITALIC="3"
END="m\]"
BOLDGREEN="${BEGIN}${BOLD};${GREEN}${END}"
ENDFORMAT="${BEGIN}${RESET}${END}"

print_pwd() {
  pwd | sed "s|$HOME|~|g"
}

get_git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

print_git_branch() {
  get_git_branch || echo "Not a git repository"
}

print_git_origin() {
  local GIT_BRANCH=$(get_git_branch)
  if [ "$GIT_BRANCH" != "" ]; then
    GIT_ORIGIN=$(git remote get-url origin 2>/dev/null || echo "No origin")
    echo -e "${GIT_ORIGIN}: "
  else
    echo ""
  fi
}

# Add formatting to terminal prefixing
print_ps1() {
  local GIT_INFO="${BEGIN}${FAINT}${END}\$(print_git_origin)${ENDFORMAT}${BEGIN}${RED}${END}(\$(print_git_branch))${ENDFORMAT}"
  local USER_INFO="${BOLDGREEN}\u${ENDFORMAT}"
  local DIR_INFO="${BEGIN}${BLUE}${END}\$(print_pwd)${ENDFORMAT}"

  echo -e "\n${GIT_INFO}\n${USER_INFO}@ ${DIR_INFO}: "
}
export PS1="$(print_ps1)"

# Change tab title
PROMPT_COMMAND='echo -en "\033]0;$(whoami)@$(print_pwd)\a"'
