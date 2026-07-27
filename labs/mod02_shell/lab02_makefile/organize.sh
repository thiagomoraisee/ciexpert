#!/bin/bash

LOGFILE="organize.log"

echo "-----=== REFERENCE FLOW ORGANIZER ===-----" > "organize.log"

touch ./$LOGFILE

echo " Creating folder structure" >> $LOGFILE
mkdir src
mkdir tb
mkdir include
mkdir scripts
mkdir docs

echo " Moving artifacts to folders" >> $LOGFILE
mv alu_tb.v tb
mv *.v src
mv *.vh include
mv *.tcl *.do scripts
mv *.md docs

tree . >> $LOGFILE
