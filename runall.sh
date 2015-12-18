#!/bin/bash

let DO_EXIT=0
for i in gnatmake g++ gcc gccgo yasm ld gmcs ghc gfortran javac erlc node awk;
do
	let EXISTS=`which $i 2>/dev/null | wc -l`
	if [ $EXISTS -eq 0 ];
	then
		DO_EXIT=1
		echo "$i does not exist, please install it."
	fi
done

if [ $DO_EXIT -eq 1 ];
then
	exit -1;
fi

rm -rf main Main.class main-haskell main-c main-cpp main-go main.o main-asm main.exe
rm -rf *.hi hworld.o *.ali main-ada main-fortran main-objc *.beam

echo "Compiling (if needed)..."
gnatmake main.adb -o main-ada
g++ -O2 main.cpp -omain-cpp
gcc -O2 main.c -omain-c
gccgo -g main.go -omain-go
yasm -f elf64 -a x86 main.asm -o main.o
ld main.o -o main-asm
gmcs main.cs
ghc hworld.hs -o main-haskell
gfortran -o main-fortran main.f95
gcc main.m -o main-objc
javac main.java
erlc main.erl

echo "Running ..."
echo
echo 'awk:'
awk -f main.awk
echo
echo "JavaScript:"
node hworld.js
echo
echo "Java:"
java -cp . Main
echo
echo "C++:"
./main-cpp
echo
echo "C:"
./main-c
echo
echo "Go:"
./main-go
echo
echo "Python3:"
python3 main.py
echo
echo "Perl:"
perl main.pl
echo
echo "ASM:"
./main-asm
echo
echo "Shell:"
sh main.sh
echo
echo "Lua:"
lua main.lua
echo
echo "C-Sharp (Mono):"
mono main.exe
echo
echo "PHP:"
php main.php
echo
echo "Ruby:"
ruby main.rb
echo
echo "Haskell:"
./main-haskell
echo
echo "Ada:"
./main-ada
echo
echo "Fortran:"
./main-fortran
echo
echo "Obj-C:"
./main-objc
echo
echo "Erlang:"
erl -noshell -s main hello_world -s init stop
echo

rm -rf main Main.class main-haskell main-c main-cpp main-go main.o main-asm main.exe 
rm -rf *.hi hworld.o *.ali main-ada main-fortran main-objc *.beam
