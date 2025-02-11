#
# DirectHW - Kernel extension to pass through IO commands to user space
#
# Copyright © 2008-2010 coresystems GmbH <info@coresystems.de>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
# 
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

all: main libs

main:
	xcodebuild -alltargets ALWAYS_SEARCH_USER_PATHS=NO -sdk macosx

libs: DirectHW.c DirectHW.h
	$(CC) DirectHW.c -dynamiclib -framework IOKit -o libDirectHW.dylib
	$(CC) -static -c DirectHW.c -o libDirectHW.a
	mv libDirectHW.dylib build/Release/libDirectHW$(LIBNAME).dylib
	mv libDirectHW.a build/Release/libDirectHW.a

install:
	sudo mkdir -p /usr/local/lib
#	sudo cp -r build/Release/DirectHW.kext /Library/Extensions/DirectHW.kext
	sudo cp -r build/Release/DirectHW.kext /usr/local/share/DirectHW.kext
	sudo cp -r build/Release/DirectHW.framework /Library/Frameworks/DirectHW.framework
	sudo cp -r build/Release/libDirectHW.a /usr/local/lib/libDirectHW.a
	sudo cp -r build/Release/libDirectHW.dylib /usr/local/lib/libDirectHW.dylib
#	sudo chmod -R 755 /Library/Extensions/DirectHW.kext
	sudo chmod -R 755 /usr/local/share/DirectHW.kext
	sudo chmod -R 755 /Library/Frameworks/DirectHW.framework
	sudo chmod 644 /usr/local/lib/libDirectHW.a
	sudo chmod 644 /usr/local/lib/libDirectHW.dylib
#	sudo chown -R root:wheel /Library/Extensions/DirectHW.kext
	sudo chown -R root:wheel /usr/local/share/DirectHW.kext
	sudo chown -R root:wheel /Library/Frameworks/DirectHW.framework
#	sudo kextunload -v /Library/Extensions/DirectHW.kext
#	sudo kextunload -v /usr/local/share/DirectHW.kext
#	sudo kextload -v /Library/Extensions/DirectHW.kext
#	sudo kextload -v /usr/local/share/DirectHW.kext
#	sudo kextcache -f -update-volume /

clean:
	rm -rf build
