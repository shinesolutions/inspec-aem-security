ci: clean deps lint

clean:
	rm -rf inspec.lock Gemfile.lock bin vendor

deps:
	gem install bundler --version=1.17.3
	bundle config --local path vendor/bundle
	bundle install --binstubs

lint:
	bundle exec inspec check .
	bundle exec rubocop Gemfile controls/ libraries/
	bundle exec yaml-lint .*.yml conf/*.yml

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
		publish-dispatcher-deny-vulnerable-urls \
		publish-dispatcher-deny-etc-libs \
		publish-dispatcher-deny-invalidate-cache

release-major:
	rtk release --release-increment-type major

release-minor:
	rtk release --release-increment-type minor

release-patch:
	rtk release --release-increment-type patch

release: release-minor

.PHONY: ci clean deps lint test test-author test-publish test-publish-dispatcher release release-major release-minor release-patch
