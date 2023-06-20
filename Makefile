ROOT=.

AR=emar
RANLIB=emranlib
CC=emcc
EXPORTS=EXPORTED_FUNCTIONS=[$(shell sed "1s/.*/'_&'/; 2,$$ s/.*/,'_&'/" $(ROOT)/exports)]
COMMON=-g -s ALLOW_MEMORY_GROWTH=1
CFLAGS=$(COMMON) -Wall -Wno-missing-braces -Wno-parentheses -Wno-gnu-designator -I$(ROOT) -I$(ROOT)/include -I$(ROOT)/kern -c -D_THREAD_SAFE -O2
O=o
LDADD=
LDFLAGS=$(COMMON) -s "$(EXPORTS)" -s EXTRA_EXPORTED_RUNTIME_METHODS='["ccall", "cwrap"]' -s TOTAL_MEMORY=33554432
TARG=dist/js/lib.js

LIBS=\
	libauthsrv/libauthsrv.a\
	libmp/libmp.a\
	libc/libc.a\
	libsec/libsec.a\
	libmemdraw/libmemdraw.a\
	libmemlayer/libmemlayer.a\
	libdraw/libdraw.a\

all: $(TARG)
$(TARG): $(LIBS)
	$(CC) $(LDFLAGS) -o $(TARG) $(OFILES) $(LIBS) $(LDADD)

.PHONY: clean
clean:
	rm -f *.o */*.o */*.a *.a blob.js blob.wasm

.PHONY: libauthsrv/libauthsrv.a
libauthsrv/libauthsrv.a:
	(cd libauthsrv; $(MAKE))

.PHONY: libmp/libmp.a
libmp/libmp.a:
	(cd libmp; $(MAKE))

.PHONY: libc/libc.a
libc/libc.a:
	(cd libc; $(MAKE))

.PHONY: libsec/libsec.a
libsec/libsec.a:
	(cd libsec; $(MAKE))

.PHONY: libmemdraw/libmemdraw.a
libmemdraw/libmemdraw.a:
	(cd libmemdraw; $(MAKE))

.PHONY: libmemlayer/libmemlayer.a
libmemlayer/libmemlayer.a:
	(cd libmemlayer; $(MAKE))

.PHONY: libdraw/libdraw.a
libdraw/libdraw.a:
	(cd libdraw; $(MAKE))
