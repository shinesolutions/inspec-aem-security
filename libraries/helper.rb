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
