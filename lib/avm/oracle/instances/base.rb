# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/oracle/connection'
require 'avm/oracle/connection_string_builder'
require 'eac_ruby_utils/core_ext'

module Avm
  module Oracle
    module Instances
      class Base < ::Avm::Instances::Base
        def database_connection
          ::Avm::Oracle::Connection.new(database_connection_string)
        end

        def database_connection_string
          ::Avm::Oracle::ConnectionStringBuilder.new(
            host: database_hostname,
            port: database_port,
            user: database_username,
            password: database_password,
            service_name: database_name
          ).build
        end
      end
    end
  end
end
