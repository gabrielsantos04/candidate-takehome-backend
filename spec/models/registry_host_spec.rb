require 'rails_helper'

RSpec.describe RegistryHost, type: :model do
  describe 'validations' do
    let(:registry_host ) { build(:registry_host, source: source, status: status) }
    let(:status) { 'active' }
    let(:source) { 'http://example.com' }

    context 'when registry_host is valid' do
      it 'should be valide' do
        expect(registry_host).to be_valid
      end
    end

    context 'when registry_host is invalid' do
      let(:source) { nil }

      it 'should not be valid' do
        expect(registry_host).not_to be_valid
      end
    end

    context 'when has a invalid status' do
      let(:status) { 'invalid' }

      it 'should not be valid' do
        expect(registry_host).not_to be_valid
      end
    end

    context 'when has a valid status' do
      it 'should be valid' do
        expect(registry_host).to be_valid
      end
    end
  end
end
