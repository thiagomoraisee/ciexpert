#!/bin/bash

mkdir src
mkdir tb
mkdir include
mkdir scripts
mkdir docs

mv alu_tb.v tb
mv *.v src
mv *.vh include
mv *.tcl *.do scripts
mv *.md docs
