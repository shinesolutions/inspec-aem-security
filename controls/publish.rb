# frozen_string_literal: true

control 'publish-non-default-admin-password' do
  impact 1.0
  title 'Check AEM does not use default admin password'
  desc 'The AEM admin account needs to be changed'
  describe aem('publish') do
    it { should_not be_able_to_login_with_credential('admin', 'admin') }
  end
end
