#!/usr/bin/env bash

# Find the directory containing this script.
dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
project=$(cd "$dir/../" && pwd)
modules="$project"/node_modules
istanbul="$modules"/.bin/istanbul
mocha="$modules"/.bin/mocha
_mocha="$modules"/.bin/_mocha
testRoot="$project/test"

usage()
{
  >&2 echo "Run unit tests, optionally with coverage."
  >&2 echo ""
  >&2 echo "Usage: $0 [OPTIONS] [path to test or directory]"
  >&2 echo "Options:"
  >&2 echo "  -h, --help      Show this help."
  >&2 echo "  -c  --coverage  Provide cover doverage report."
  exit 1;
}

# Defaults
coverage=false
testPath=

# Read Command Line Arguments
while [ "$1" != "" ]; do
  case "$1" in
    -h|--help)
      usage
      ;;
    -c|--coverage)
      coverage=true
      ;;
    -*)
      usage
      ;;
    *)
      testPath="${1#*=}"
      ;;
  esac
  shift
done

if [ "$coverage" = true ] ; then

  # Run with code coverage.

  if [ ! -z "$testPath" ] ; then
    # Single test or directory
    if [ ! -e "$testPath" ] ; then
      testPath="$testRoot"/"$testPath"
    fi
    "$istanbul" cover "$_mocha" -- --recursive "$testPath"
  else
    # All tests
    "$istanbul" cover "$_mocha" -- --recursive "$testRoot"
  fi

  # # Ensure the symlink exists.
  # if [ ! -d "$project"/coverage ] ; then
  #   mkdir "$project"/coverage
  # fi
  # if [ ! -h "$project"/htdocs/coverage/js ] ; then
  #   ln -s "$project"/coverage/lcov-report/ "$project"/htdocs/coverage/js
  # fi
  #
  # echo "See /coverage/js/ through the Web server for the report."

else

  # Run without code coverage.

  if [ ! -z "$testPath" ] ; then
    # Single test or directory
    if [ ! -e "$testPath" ] ; then
      testPath="$testRoot"/"$testPath"
    fi
    "$mocha" "$testPath"
  else
    # All tests
    "$mocha" --recursive "$testRoot"
  fi

fi
