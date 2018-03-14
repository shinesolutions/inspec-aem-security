control 'publish-non-default-admin-password' do
  impact 1.0
  desc 'The AEM admin account needs to be changed'
  describe aem('publish') do
    it { should have_non_default_admin_password }
  end
end
