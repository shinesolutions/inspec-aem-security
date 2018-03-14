ci: tools deps lint

deps:
	bundle install

lint:
	inspec check .
	rubocop

test:
	inspec exec .

test-author:
	inspec exec . --controls="author-*"

test-publish:
	inspec exec . --controls="publish-*"

test-publish-dispatcher:
	inspec exec . --controls="publish-dispatcher-*"

tools:
	gem install bundler

.PHONY: ci deps lint test test-author test-publish test-publish-dispatcher tools
