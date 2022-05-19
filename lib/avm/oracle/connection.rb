# frozen_string_literal: true

require 'avm/oracle/query_builder'
require 'oci8'

module Avm
  module Oracle
    class Connection
      require_sub __FILE__
      delegate :exec, to: :connection

      def initialize(connection_string)
        @connection = ::OCI8.new(connection_string)
      end

      def first_row(query_sql, query_args = {})
        query(query_sql, query_args) { |row| return row }
        nil
      end

      def first_value(query_sql, query_args = {})
        first_row(query_sql, query_args).if_present(&:first)
      end

      def query(query_sql, query_args = {}, &block)
        if block
          query_with_block(query_sql, query_args, block)
        else
          query_without_block(query_sql, query_args)
        end
      end

      def objects
        @objects ||= ::Avm::Oracle::Objects.new(self)
      end

      private

      attr_reader :connection

      # @return [Avm::Oracle::Connection::Cursor]
      def query_without_block(query_sql, query_args)
        query_builder = ::Avm::Oracle::QueryBuilder.new(query_sql, query_args)
        Avm::Oracle::Connection::Cursor.new(
          connection.exec(query_builder.oci8_exec_sql, *query_builder.oci8_exec_bind_vars)
        )
      end

      def query_with_block(query_sql, query_args, block)
        cursor = query_without_block(query_sql, query_args)
        begin
          while (row = cursor.fetch_hash)
            block.call(row)
          end
        ensure
          cursor.close
        end
      end
    end
  end
end
