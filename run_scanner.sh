#!/bin/sh

rm -rf ./output/output.txt
jflex Lexical.flex
javac Scanner.java
java Scanner input/input.vc
