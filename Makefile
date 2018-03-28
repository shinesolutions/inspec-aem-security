ci: tools deps lint

clean:
	rm Gemfile.lock inspec.lock

deps:
	bundle install

lint:
	inspec check .
	rubocop

test:
	inspec exec .

test-author:
	inspec exec . --show-progress --controls=author-non-default-admin-password

test-publish:
	inspec exec . --show-progress --controls=publish-non-default-admin-password

test-publish-dispatcher:
	inspec exec . --show-progress --controls=\
	  publish-dispatcher-prevent-clickjacking \
		publish-dispatcher-deny-administrative-urls \
		publish-dispatcher-deny-etc-libs \
		publish-dispatcher-deny-invalidate-cache

tools:
	gem install bundler

.PHONY: ci clean deps lint test test-author test-publish test-publish-dispatcher tools
