params = yaml(content: inspec.profile.file('publish.yml')).params

control 'publish-non-default-admin-password' do
  impact 1.0
  title 'Should not be able to login using default admin password'
  desc 'The AEM admin account needs to be changed'
  describe http(params['base_url'] + '/libs/granite/core/content/login.html', auth: { user: 'admin', pass: 'admin' }, enable_remote_worker: true) do
    its('status') { should cmp 401 }
  end
end
