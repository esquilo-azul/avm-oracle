# frozen_string_literal: true

require 'avm/oracle/query_builder'

::RSpec.describe ::Avm::Oracle::QueryBuilder do
  let(:sql) do
    'select * from table where firstname = :name or age = :Age or lastname = :name or x = :y'
  end
  let(:bind_vars) { {} }
  let(:instance) { described_class.new(sql, bind_vars) }

  describe '#oci8_exec_sql' do
    it { expect(instance.oci8_exec_sql).to eq(sql) }
  end

  describe '#bind_vars_in_sql' do
    it { expect(instance.bind_vars_in_sql).to eq(%w[name Age name y]) }
  end

  describe '#oci8_exec_bind_vars' do
    context 'when there is all bind_vars' do
      let(:bind_vars) do
        {
          name: 'Fulano',
          'Age' => 33,
          y: 'Z'
        }
      end

      it { expect(instance.oci8_exec_bind_vars).to eq(['Fulano', 33, 'Fulano', 'Z']) }
    end

    context 'when some bind var is missing' do
      let(:bind_vars) do
        {
          name: 'Fulano',
          'Age' => 33
        }
      end

      it do
        expect { instance.oci8_exec_bind_vars }.to raise_error(::KeyError)
      end
    end
  end
end
