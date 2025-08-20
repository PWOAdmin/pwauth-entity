lib_LTLIBRARIES = libpwauth.la
libpwauth_la_SOURCES=src/work-punks-authority.ads
obj_DIRS=obj
libpwauth_la_LIBADD=
LIBS=
EXTRA_DIST = pwauth.gpr tests/tests.gpr tests/*.ad* src/*
all-local:
	gprbuild -d -Ppwauth.gpr -XLIBRARY_TYPE=relocatable -XAWS_BUILD=relocatable
	gprbuild -d -Ptests/tests.gpr -XLIBRARY_TYPE=relocatable -XAWS_BUILD=relocatable
LINK=

check-local: all-local
	./tests/obj/test_driver

format:
	find . -type f -name '*.ad*'  -print0 |xargs -0 gnatpp --max-line-length=120 --split-line-before-op -l2

clean-local:
	rm -rf ${obj_DIRS}/*
	rm -rf lib/*
	rm -rf tests/obj/*
	rm -rf *.o
	rm -rf *.ali
	rm -rf *.so
	rm -rf configure~
	rm -rf autom4te.cache/*
	rm -rf autom4te.cache