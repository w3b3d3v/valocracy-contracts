#!/bin/bash

# Remove unwanted documentation files
rm -rf docs/src/math
rm -rf docs/src/mocks
rm -f docs/src/Valocracy.sol/error.TokenSoulbound.md

# Rebuild the documentation
mdbook build docs 