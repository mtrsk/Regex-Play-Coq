all:
	$(MAKE) check
	$(MAKE) clean

check:
	bash ./compile.sh

clean:
	rm src/*.vo
	rm src/*.glob
