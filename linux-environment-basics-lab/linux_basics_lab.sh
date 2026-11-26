#!/bin/bash
echo "=== Part 1: Meet the Terminal ==="
echo "User: $(whoami)"
echo "Working Directory: $(pwd)"
echo "Shell: $SHELL"

echo "=== Part 2: Home, Root, and Paths ==="
echo "Home (~): ~"
echo "Home (\$HOME): $HOME"
ls -ld "$HOME/linux_prework/l1_q6"

echo "=== Part 3: Absolute and Relative Paths ==="
ls -ld "$HOME/linux_prework/l1_q9/data/raw"
ls -ld "$HOME/linux_prework/l1_q10/one/two"
cat "$HOME/linux_prework/l1_q11/message.txt"

echo "=== Part 4: Variables & Paths with Spaces ==="
COURSE_NAME="Data Engineering"
export DE_PROJECT="linux_prework"
echo "COURSE_NAME: $COURSE_NAME"
printenv DE_PROJECT
ls -ld "$HOME/linux_prework/l1_q15/My Data"
