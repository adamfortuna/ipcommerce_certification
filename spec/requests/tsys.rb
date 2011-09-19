# Host Capture: FDC

require 'spec_helper'
describe VaultedBilling::Gateways::Ipcommerce do
  it_should_behave_like 'a terminal capture account', { :merchant_profile_id => 'TicketTest_C82ED00001', :workflow_id => 'C82ED00001' }, 'T'
end

