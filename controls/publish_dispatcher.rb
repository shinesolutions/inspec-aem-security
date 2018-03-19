control 'publish-dispatcher-prevent-clickjacking' do
  impact 1.0
  title 'Check clickjacking prevention setup'
  desc 'To prevent clickjacking we recommend that you configure your webserver to provide the X-FRAME-OPTIONS HTTP header set to SAMEORIGIN.'
  describe httpd('publish_dispatcher') do
    it { should have_same_origin_x_frame_options }
  end
end
