require_relative './helper'

class Httpd < Inspec.resource(1)
  include Capybara::DSL
  name 'httpd'

  desc "
    Custom resource for Apache httpd
  "

  def initialize(component)
    conf = read_config[component]
    @client = init_http_client(conf)

    @params = {}
  end

  # should have X-FRAME-OPTIONS header set to SAMEORIGIN
  # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
  def has_same_origin_x_frame_options?
    visit '/'
    response_headers['X-Frame-Options'].eql? 'SAMEORIGIN'
  end

end
