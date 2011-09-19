# Terminal Capture: Vantiv / 5th 3rd Bank

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a terminal capture account', { :merchant_profile_id => 'TicketTest_B447F00001', :workflow_id => 'B447F00001' }, 'V'
end