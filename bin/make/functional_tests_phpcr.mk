
functional_tests_phpcr:
	@if [ "${CONSOLE}" = "" ]; then echo "Console executable missing"; exit 1; fi
	@echo
	@echo '+++ create PHPCR +++'
	@${CONSOLE} doctrine:phpcr:init:dbal --drop --force
	@${CONSOLE} doctrine:phpcr:repository:init
	@echo '+++ run PHPCR functional tests +++'
ifeq ($(HAS_XDEBUG), 0)
	@vendor/bin/simple-phpunit --coverage-clover build/logs/clover.xml --testsuite "functional tests with phpcr"
else
	@vendor/bin/simple-phpunit --testsuite "functional tests with phpcr"
endif
	@${CONSOLE} doctrine:database:drop --force
