# Host Capture: FDC

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a host capture account', { :merchant_profile_id => 'TicketTest_E4FB800001', :workflow_id => 'E4FB800001' }, 'F', :expires_credit_card
end