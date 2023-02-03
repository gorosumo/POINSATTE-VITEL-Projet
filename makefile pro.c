all : exe

code_abr.o : code_abr.c header_abr.h
gcc -c code_abr.c -o code_abr.o

code_avl.o : code_avl.c header_avl.h
gcc -c code_avl.c -o code_avl.o

code_tab.o : code_tab.c header_tab.h
gcc -c code_tab.c -o code_tab.o

main.o : main.c main.h
gcc -c main.c -o main.o

exe : code_abr.o code_avl.o code_tab.o
gcc code_abr.o code_avl.o code_tab.o main.o -o exe

clean :
rm -f *,o