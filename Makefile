all:
	$(MAKE) check
	$(MAKE) clean

check:
	./compile.sh

clean:
	rm src/*.vo
	rm src/*.glob
