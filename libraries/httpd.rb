# Copyright 2018 Shine Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require_relative './helper'

# Httpd class contains security checks relevant to an Apache httpd instance
# used by AEM Author Dispatcher and AEM Publish Dispatcher
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

  # should deny access to administrative URLs
  # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
  def has_administrative_urls_denied?
    administrative_urls = File.readlines('conf/administrative_paths.txt')
    has_urls_denied?(administrative_urls)
  end

  # should deny access to root directories of /etc and /libs'
  def has_etc_libs_denied?
    has_urls_denied?(['/etc/', '/libs/'])
  end

  def has_urls_denied?(urls)
    has_urls_denied = true
    urls.each do |url|
      visit url
      # follow redirect since Capybara does not do this automatically
      visit response_headers['Location'] if response_headers.key?('Location')
      # wait for page load to prevent missing checks
      # https://stackoverflow.com/questions/36108196/how-to-get-poltergeist-phantomjs-to-delay-returning-the-page-to-capybara-until-a
      page.has_content?('.+')

      puts "Checking denied url: #{page.status_code} - #{url}"

      unless page.status_code.eql? 404
        has_urls_denied = false
        break
      end
    end
    has_urls_denied
  end

  # should not be able to invalidate Dispatcher cache
  # https://helpx.adobe.com/experience-manager/dispatcher/using/security-checklist.html
  def has_invalidate_cache_denied?
    # set http headers to invalidate cache
    headers = { 'CQ-Handle' => '/content', 'CQ-Path' => '/content' }
    Capybara.current_session.driver.add_headers(headers)
    visit '/dispatcher/invalidate.cache'

    # NOTE: AEM documentation states 404, but default Dispatcher config returns 403
    page.status_code.eql? 403
  end
end
