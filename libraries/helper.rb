# frozen_string_literal: true

# Copyright 2018-2021 Shine Solutions Group
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

def read_config(component)
  conf_file = ENV['INSPEC_AEM_SECURITY_CONF'] || './conf/aem.yml'
  config = YAML.load_file(conf_file)[component] if File.exist?(conf_file)
  config_params = {}

  %w[protocol host port verify_ssl debug use_proxy].each { |field|
    env_field = format('aem_%<field>s', field: field)
    if !ENV[env_field].nil?
      config_params[:"#{field}"] = ENV[env_field]
    elsif !config.nil? && !config[field].nil?
      config_params[:"#{field}"] = config[field]
    end
  }
  config_params
end

def init_capybara_client(conf)
  Capybara.register_driver :poltergeist do |app|
    ignore_ssl_errors_value = conf[:verify_ssl] == false ? 'yes' : 'no'
    use_proxy = conf[:use_proxy] == false ? 'none' : 'http'
    phantomjs_options_value = [
      "--debug=#{conf[:debug]}",
      "--ignore-ssl-errors=#{ignore_ssl_errors_value}",
      '--ssl-protocol=any',
      "--proxy-type=#{use_proxy}",
    ]
    Capybara::Poltergeist::Driver.new(app, js_errors: false, debug: conf[:debug], phantomjs_options: phantomjs_options_value)
  end

  Capybara.current_driver = :poltergeist
  Capybara.app_host = "#{conf[:protocol]}://#{conf[:host]}:#{conf[:port]}"
end

def init_ruby_aem_client(conf)
  RubyAem::Aem.new(
    username: conf[:username],
    password: conf[:password],
    protocol: conf[:protocol] || 'http',
    host: conf[:host] || 'localhost',
    port: conf[:port],
    verify_ssl: conf[:verify_ssl] ? conf[:verify_ssl] == true : false,
    debug: conf[:debug] ? conf[:debug] == true : false
  )
end
