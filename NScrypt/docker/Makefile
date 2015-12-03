bitstation-nocache: ARGS="--no-cache=true"
bitstation-nocache: nscrypt

ifeq ($(NOCACHE),true)
ARGS="--no-cache=true"
endif

nscrypt:
	 docker build -t nscrypt $(ARGS) nscrypt

.PHONY: nscrypt


