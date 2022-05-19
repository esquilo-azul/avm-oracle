# frozen_string_literal: true

module Avm
  module Oracle
    class ConnectionStringBuilder
      DEFAULT_PORT = 1521

      FIELDS = %w[user password host port service_name].freeze

      attr_accessor(*FIELDS)
      attr_accessor :string

      def initialize(options = nil)
        if options.is_a?(String)
          self.string = options
        elsif options.is_a?(Hash)
          options.each do |k, v|
            send("#{k}=", v)
          end
        end
      end

      def port
        @port || DEFAULT_PORT
      end

      def build
        if string
          string
        else
          validate_fields
          "#{user}/#{password}@//#{host}:#{port}/#{service_name}"
        end
      end

      private

      def validate_fields
        FIELDS.each { |f| raise "\"#{f}\" is blank" if send(f).blank? }
      end
    end
  end
end
