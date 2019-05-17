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

# Aem class contains security checks relevant to an AEM instance,
# used by AEM Author and AEM Publish
class Aem < Inspec.resource(1)
  include Capybara::DSL
  name 'aem'

  desc "
    Custom resource for AEM, used by AEM Author and AEM Publish
  "

  def initialize(component)
    @conf = read_config[component]
    @ruby_aem = init_ruby_aem_client(@conf)

    @params = {}
  end

  # should change default password for AEM admin account
  # https://helpx.adobe.com/experience-manager/6-3/sites/administering/using/security-checklist.html
  def able_to_login_with_credential?(username, password)
    init_capybara_client(@conf)

    visit '/libs/granite/core/content/login.html'
    fill_in('username', with: username)
    fill_in('password', with: password)
    click_button('submit-button')
    page.title == 'AEM Projects'
  end
end
