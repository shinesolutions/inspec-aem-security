control 'publish-dispatcher-prevent-clickjacking' do
  impact 1.0
  title 'Check clickjacking prevention setup'
  desc 'To prevent clickjacking we recommend that you configure your webserver to provide the X-FRAME-OPTIONS HTTP header set to SAMEORIGIN.'
  describe httpd('publish_dispatcher') do
    # should have X-FRAME-OPTIONS header set to SAMEORIGIN
    # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
    it { should have_response_header_with_value('X-Frame-Options', 'SAMEORIGIN')}
  end
end

control 'publish-dispatcher-deny-administrative-urls' do
  impact 1.0
  title 'Check access to administrative URLs is denied '
  desc 'Dispatcher filters should block access to the following pages and scripts on AEM publish instances.'
  describe httpd('publish_dispatcher') do
    # should deny access to administrative URLs
    # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
    administrative_paths = File.readlines('conf/administrative_paths.txt')
    administrative_paths.each do |path|
      it { should have_path_with_status_code(path, 404) }
    end
  end
end

control 'publish-dispatcher-deny-etc-libs' do
  impact 1.0
  title 'Check root directories are denied'
  desc 'Should deny access to root directories of /etc and /libs'
  describe httpd('publish_dispatcher') do
    it { should have_path_with_status_code('/etc/', 404) }
    it { should have_path_with_status_code('/libs/', 404) }
  end
end

control 'publish-dispatcher-deny-invalidate-cache' do
  impact 1.0
  title 'Check invalidate Dispatcher cache is denied'
  desc 'Should not be able to invalidate Dispatcher cache'
  describe httpd('publish_dispatcher') do
    opts = {
      'headers' => {
        'CQ-Handle' => '/content',
        'CQ-Path' => '/content'
      }
    }
    # should not be able to invalidate Dispatcher cache
    # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
    # TODO: AEM documentation states 404, but default Dispatcher config returns 403,
    # this is due to https://github.com/shinesolutions/puppet-aem-resources/issues/29
    it { should have_path_with_status_code('/dispatcher/invalidate.cache', 403, opts) }
  end
end
