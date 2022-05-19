# frozen_string_literal: true

module Avm
  module Oracle
    class Connection
      class Cursor < ::SimpleDelegator
        def fetch_hash
          sanitized_fetch_hash
        end

        def sanitized_fetch_hash
          r = super_fetch_hash
          return nil if r.nil?

          r.map { |k, v| [k.downcase.to_sym, v] }.to_h
        end

        def super_fetch_hash
          __getobj__.fetch_hash
        end
      end
    end
  end
end
