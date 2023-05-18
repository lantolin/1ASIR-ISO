#!/bin/bash

T=$(date  +"%Y-%m-%d_%H.%M.%S")
F=$(df / | tail -1)

echo "[$T] $F";