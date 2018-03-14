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

require 'capybara/dsl'
require 'capybara/poltergeist'
require 'ruby_aem'

def read_config
  YAML.load_file('./conf/aem.yml')
end

def init_http_client(conf)
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, js_errors: false)
  end

  Capybara.current_driver = :poltergeist
  Capybara.app_host = "#{conf['protocol']}://#{conf['host']}:#{conf['port']}"
end

def init_aem_client(conf)
  RubyAem::Aem.new(
    username: conf['username'],
    password: conf['password'],
    protocol: conf['protocol'] || 'http',
    host: conf['host'] || 'localhost',
    port: conf['port'] ? conf['port'].to_i : 4502,
    debug: conf['debug'] ? conf['debug'] == true : false
  )
end
