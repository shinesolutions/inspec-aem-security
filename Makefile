ci: tools deps lint

clean:
	rm *.lock bin vendor

deps:
	bundle config --local path vendor/bundle
	bundle install --binstubs

lint:
	bundle exec inspec check .
	bundle exec rubocop Gemfile controls/ libraries/

test:
	bundle exec inspec exec .

test-author:
	bundle exec inspec exec . --show-progress --controls=author-non-default-admin-password

test-publish:
	bundle exec inspec exec . --show-progress --controls=publish-non-default-admin-password

test-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-dispatcher-prevent-clickjacking \
		publish-dispatcher-deny-administrative-urls \
		publish-dispatcher-deny-etc-libs \
		publish-dispatcher-deny-invalidate-cache

tools:
	gem install bundler

.PHONY: ci clean deps lint test test-author test-publish test-publish-dispatcher tools
