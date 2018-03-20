control 'publish-dispatcher-prevent-clickjacking' do
  impact 1.0
  title 'Check clickjacking prevention setup'
  desc 'To prevent clickjacking we recommend that you configure your webserver to provide the X-FRAME-OPTIONS HTTP header set to SAMEORIGIN.'
  describe httpd('publish_dispatcher') do
    it { should have_same_origin_x_frame_options }
  end
end

control 'publish-dispatcher-deny-administrative-urls' do
  impact 1.0
  title 'Check access to administrative URLs is denied '
  desc 'Dispatcher filters should block access to the following pages and scripts on AEM publish instances.'
  describe httpd('publish_dispatcher') do
    it { should have_administrative_urls_denied }
  end
end

control 'publish-dispatcher-deny-etc-libs' do
  impact 1.0
  title 'Check root directories are denied'
  desc 'Should deny access to root directories of /etc and /libs'
  describe httpd('publish_dispatcher') do
    it { should have_etc_libs_denied }
  end
end

control 'publish-dispatcher-deny-invalidate-cache' do
  impact 1.0
  title 'Check invalidate Dispatcher cache is denied'
  desc 'Should not be able to invalidate Dispatcher cache'
  describe httpd('publish_dispatcher') do
    it { should have_invalidate_cache_denied }
  end
end
