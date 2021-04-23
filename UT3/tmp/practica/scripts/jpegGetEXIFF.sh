#!/bin/bash
identify -format "%f: %[EXIF:*]" $*
