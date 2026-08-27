# 03 — Widget Classes, Not Builder Functions

## Problem

A function that returns a `Widget` looks like a widget but isn't one.
It has no `Element` of its own in the tree, so it can't be isolated or
skipped on rebuild — every rebuild of whatever called it rebuilds this
too. It also won't show up as its own node in the widget inspector.

`buildRecipeGridCard` was written this way, and it's called once per
item in a grid — exactly where this matters most.

## What changed

`buildRecipeGridCard` became `RecipeGridCard`, a `StatelessWidget`. Same
UI, same behavior.

This is now a standing rule for the project, not a one-off fix: a widget
is a class, never a function or a build-helper method.
