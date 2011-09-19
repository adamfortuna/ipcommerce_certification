# Host Capture: RBS Worldpay

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a host capture account', { :merchant_profile_id => 'Merchant_832E400001', :workflow_id => '832E400001' }, 'R', :avs_credit_card
end