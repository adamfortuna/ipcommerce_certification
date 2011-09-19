# Host Capture: Intuit

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a host capture account', { :merchant_profile_id => 'Merchant_8077500001', :workflow_id => '8077500001' }, 'I', :expires_credit_card
end