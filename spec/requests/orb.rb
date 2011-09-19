# Host Capture: Orb Tampa (Chase Paymentech Orbital - Tampa (214DF00001))

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a host capture account', { :merchant_profile_id => 'Merchant_214DF00001', :workflow_id => '214DF00001' }, 'OT', :expires_credit_card
end