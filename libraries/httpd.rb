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
end
