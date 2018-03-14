ci: tools deps lint

deps:
	bundle install

lint:
	inspec check .
	rubocop

test:
	inspec exec .

test-author:
	inspec exec . --controls="author-non-default-admin-password"

test-publish:
	inspec exec . --controls="publish-non-default-admin-password"

test-publish-dispatcher:
	inspec exec . --controls="publish-dispatcher-prevent-clickjacking"

tools:
	gem install bundler

.PHONY: ci deps lint check check-author check-publish check-dispatcher tools
