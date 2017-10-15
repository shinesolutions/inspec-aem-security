params = yaml(content: inspec.profile.file('publish_dispatcher.yml')).params

control 'publish-dispatcher-prevent-clickjacking' do
  impact 1.0
  title 'Should have X-FRAME-OPTIONS header set to SAMEORIGIN'
  desc 'To prevent clickjacking we recommend that you configure your webserver to provide the X-FRAME-OPTIONS HTTP header set to SAMEORIGIN.'
  describe http(params['base_url'], enable_remote_worker: true) do
    its('headers.X-FRAME-OPTIONS') { should cmp 'SAMEORIGIN' }
  end
end
