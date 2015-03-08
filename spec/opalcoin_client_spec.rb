require 'opalcoin_client/client'

describe OpalcoinClient do

  def valid_client
    # make sure to replace these with the credentials from your own opalcoind
    OpalcoinClient.new(user: 'opalcoinrpc', password: '5d36c07c20a43a281f54c07d72ce78cc')
  end

  it 'sets up and works with a valid client' do
    bad_client = OpalcoinClient.new
    bad_client.valid?.should eql(false)

    valid_client.valid?.should eql(true)
  end

  it 'calls client methods correctly' do
    addr = valid_client.get_new_address
    addr[0].should eql('o')
  end

  it 'configures itself properly' do
    OpalcoinClient.configure do |config|
      config.user = 'opalcoinrpc'
      config.password = '5d36c07c20a43a281f54c07d72ce78cc'
    end
    client = OpalcoinClient.new
    client.valid?.should eql(true)
  end

  it 'using results as args' do
    client = valid_client
    new_wallet_addr = client.get_new_address
    my_balance = client.get_balance(new_wallet_addr)
    my_balance.should eql(0.0)
  end

end
