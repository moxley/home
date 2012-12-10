# Git Cheatsheet

## What commits does my branch introduce?
git log master..HEAD

## What files does my branch change?
`git diff --name-status master..HEAD`

## What lines does my branch change?
`git diff master..HEAD`
