#!/bin/bash

pixi run jupyter book build --execute --pdf
pixi run jupyter book build --execute --html --strict

