# frozen_string_literal: true

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
    @conf = read_config[component]

    @params = {}
  end

  def has_response_header_with_value?(header, value)
    init_capybara_client(@conf)

    visit '/'
    response_headers[header].eql? value
  end

  def has_path_with_status_code?(path, status_code, opts = {})
    init_capybara_client(@conf)

    # set headers
    Capybara.current_session.driver.add_headers(opts['headers']) if opts['headers']

    visit path

    # follow redirect since Capybara does not do this automatically
    visit response_headers['Location'] if response_headers.key?('Location')

    # wait for page load to prevent missing checks
    # https://stackoverflow.com/questions/36108196/how-to-get-poltergeist-phantomjs-to-delay-returning-the-page-to-capybara-until-a
    page.has_content?('.+')

    page.status_code.eql? status_code
  end

  def has_path_within_status_codes?(path, status_codes, opts = {})
    status_codes.any? {|status_code| should has_path_with_status_code?(path, status_code, opts)}
  end
end
