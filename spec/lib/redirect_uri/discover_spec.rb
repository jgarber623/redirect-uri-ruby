describe RedirectUri::Discover do
  context 'when not given an HTTP::Response' do
    let(:message) { 'response must be an HTTP::Response (given NilClass)' }

    it 'raises an ArgumentError' do
      expect { described_class.new(nil) }.to raise_error(RedirectUri::ArgumentError, message)
    end
  end
end
