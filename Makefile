CC := /usr/bin/i686-w64-mingw32-gcc

CFLAGS := -I /home/ubuntu/x86_64/include -fopenmp -static

LDFLAGS := -L /home/ubuntu/x86_64/lib -lwinmm -fopenmp -static -lole32

prx-rename.exe: prx-rename.c
	$(CC) $(CFLAGS) prx-rename.c $(LDFLAGS) -o prx-rename.exe

clean:
	rm prx-rename.exe
