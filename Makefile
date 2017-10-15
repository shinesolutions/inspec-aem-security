ci: tools deps lint

deps:
	bundle install

lint:
	inspec check .
	rubocop

check:
	inspec exec .

check-author:
	inspec exec . --controls="author-non-default-admin-password"

check-publish:
	inspec exec . --controls="publish-non-default-admin-password"

check-publish-dispatcher:
	inspec exec . --controls="publish-dispatcher-prevent-clickjacking"

tools:
	gem install bundler

.PHONY: ci deps lint check check-author check-publish check-dispatcher tools
