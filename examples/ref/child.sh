#!/usr/bin/env bash 

echo "Child Process ID is $$"
echo "My Father Process ID is $PPID"

echo "localvar=$localvar"
echo "ENVVAR=$ENVVAR"

localvar="Redfine this local variable."
ENVVAR="Redfine this environment variable."
echo "localvar=$localvar"
echo "ENVVAR=$ENVVAR"
