# frozen_string_literal: true

module Avm
  module Oracle
    class QueryBuilder
      common_constructor :sql, :bind_vars, default: [{}] do
        self.bind_vars = bind_vars.with_indifferent_access
      end

      def oci8_exec_sql
        sql
      end

      def oci8_exec_bind_vars
        bind_vars_in_sql.map { |key| bind_vars.fetch(key) }
      end

      def bind_vars_in_sql
        sql.scan(/:([a-z][a-z0-9_]*)/i).map(&:first)
      end
    end
  end
end
