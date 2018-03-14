require_relative './helper'

class Aem < Inspec.resource(1)
  include Capybara::DSL
  name 'aem'

  desc "
    Custom resource for AEM, used by AEM Author and AEM Publish
  "

  def initialize(component)
    conf = read_config[component]
    @client = init_aem_client(conf)

    @params = {}
  end

  # should change default password for AEM admin account
  # https://helpx.adobe.com/experience-manager/6-3/sites/administering/using/security-checklist.html
  def has_non_default_admin_password
    @conf['username'] = 'admin'
    @conf['password'] = 'admin'
    aem = init_aem_client(conf).aem

    begin
      result = aem.get_agents(aem_role)
      has_non_default_admin_password = false
    rescue RubyAem::Error => error
      if error.result.response.status_code.eql? 401
        has_non_default_admin_password = true
      end
      raise error
    end
    has_non_default_admin_password
  end

end
