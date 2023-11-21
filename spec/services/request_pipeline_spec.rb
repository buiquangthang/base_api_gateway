# frozen_string_literal: true

RSpec.describe RequestPipeline, type: :service do
  describe '#execute' do
    let(:params) { { method: 'GET', url_pattern: '/api/v1/example', path: '/resource' } }
    let(:api_params) { { key: 'value' } }

    context 'when a matching route is found' do
      let(:service) { create(:service, url: 'http://example.com', token: 'token123') }
      let(:route) { create(:route, verb: 'get', version: 'v1', url_pattern: 'example', service:) }

      before do
        allow(Route).to receive(:where).and_return([route])
      end

      it 'makes a request with the correct parameters' do
        expected_url = 'http://example.com/resource'
        expected_token_header = 'token123'

        expect(Requester).to receive(:make_request).with('get', expected_url, expected_token_header, api_params)

        described_class.new(params, api_params).execute
      end
    end

    context 'when no matching route is found' do
      before do
        allow(Route).to receive(:where).and_return([])
      end

      it 'returns an empty hash' do
        expect(Requester).not_to receive(:make_request)
        result = described_class.new(params, api_params).execute
        expect(result).to eq({})
      end
    end
  end
end
