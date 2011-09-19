shared_examples_for 'a host capture account' do |options, batch, credit_card_factory|
  let(:gateway) { VaultedBilling.gateway(:ipcommerce).new }
  
  before(:all) do
    puts "test code, status code, approval code, status message, transaction id"
  end

  context "AuthorizeAndCapture" do
    let(:purchase) { gateway.purchase(nil, credit_card, amount, options) }
    
    subject { IpcommerceTransaction.new(code, purchase) }
    
    context 'setup' do
      use_vcr_cassette "#{batch}/a-setup"
      it "clears captures" do
        gateway.capture_all(options)
      end
    end
    
    context 'A1' do
      let(:code) { "#{batch}_A1" }
      let(:amount) { 12.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111') }
      use_vcr_cassette "#{batch}/f_a1"
      
      it "outputs the result" do
        puts subject.print
      end
    end
    
    context 'A2' do
      let(:code) { "#{batch}_A2" }
      let(:amount) { 12.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '6011000995504101') }
      use_vcr_cassette "#{batch}/f_a2"
      
      it "outputs the result" do
        puts subject.print
      end
    end
    
    context'A3' do
      let(:code) { "#{batch}_A3" }
      let(:amount) { 25.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456', :cvv_number => '1111') }
      use_vcr_cassette "#{batch}/a3"
      
      it "outputs the result" do
        puts subject.print
      end
    end
    
    context 'A4' do
      let(:code) { "#{batch}_A4" }
      let(:amount) { 26.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/a4"
      
      it "outputs the result" do
        puts subject.print
      end
    end
    
    context 'A5' do
      let(:code) { "#{batch}_A5" }
      let(:amount) { 12.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456') }
      use_vcr_cassette "#{batch}/a5"
      
      it "outputs the result" do
        puts subject.print
      end
    end
    
    context 'A6' do
      let(:code) { "#{batch}_A6" }
      let(:amount) { 10.83 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :cvv_number => '777') }
      use_vcr_cassette "#{batch}/a6"
      
      it "outputs the result" do
        puts subject.print
      end
    end
  end
  
  
  context 'ReturnById' do
    let(:purchase) { gateway.purchase(nil, credit_card, purchase_amount, options) }
    let(:refund) { gateway.refund(purchase.id, refund_amount, options) }
    
    context 'B1 - B2' do
      let(:purchase_amount) { 29.00 }
      let(:refund_amount) { 12.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/b1-b2"
      
      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_B1", purchase).print
        puts IpcommerceTransaction.new("#{batch}_B2", refund).print
      end
    end
    
    context 'B3 - B4' do
      let(:purchase_amount) { 7.00 }
      let(:refund_amount) { purchase_amount }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/f_b3-b4"
      
      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_B3", purchase).print
        puts IpcommerceTransaction.new("#{batch}_B4", refund).print
      end
    end  
  end

  context 'Undo (Void)' do
    let(:authorization) { gateway.authorize(nil, credit_card, amount, options) }
    let(:void) { gateway.void(authorization.id, options) }

    context 'C1 - C2' do
      let(:amount) { 57.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/f_c1-c2"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_C1", authorization).print
        puts IpcommerceTransaction.new("#{batch}_C2", void).print
      end
    end

    context 'C3 - C4' do
      let(:amount) { 55.00 }
      let(:authorization) { gateway.authorize(nil, credit_card, amount, options) }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111') }
      use_vcr_cassette "#{batch}/c3-c4"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_C3", authorization).print
        puts IpcommerceTransaction.new("#{batch}_C4", void).print
      end
    end
  end
  
  
  context 'Non-Standard Card Tests (Purchase)' do
    let(:purchase) { gateway.purchase(nil, credit_card, amount, options) }

    context 'D1' do
      let(:amount) { 17.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '6011000995504101', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/d1"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_D1", purchase).print
      end
    end

    context 'D2' do
      let(:amount) { 33.03 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111') }
      use_vcr_cassette "#{batch}/f_d2"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_D2", purchase).print
      end
    end
    
    context 'D3' do
      let(:amount) { 34.02 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111') }
      use_vcr_cassette "#{batch}/d3"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_D3", purchase).print
      end
    end
    
    context 'D4' do
      let(:amount) { 35.05 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454') }
      use_vcr_cassette "#{batch}/f_d4"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_D4", purchase).print
      end
    end   
  end
  
  context 'Voice Authorization Tests' do
    let(:purchase) { gateway.purchase(nil, credit_card, amount, options.merge(:approval_code => '555123')) }
    let(:amount) { 8.00 }
    let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :cvv_number => '111') }
    use_vcr_cassette "#{batch}/f_v1"

    it "V1" do
      puts IpcommerceTransaction.new("#{batch}_V1", purchase).print
    end
  end
  
  context 'Pre-authorization Tests' do
    let(:authorization) { gateway.authorize(nil, credit_card, amount, options) }
    let(:purchase) { gateway.purchase(nil, credit_card, amount, options) }
    let(:capture) { gateway.capture(authorization.id, amount, options) }
    
    context 'F1 - F2' do
      let(:amount) { 18.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456') }  
      use_vcr_cassette "#{batch}/f1-f2"
      
      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_F1", authorization).print
        puts IpcommerceTransaction.new("#{batch}_F2", capture).print
      end
    end
    
    context 'F3 - F4' do
      let(:amount) { 13.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454') }
      use_vcr_cassette "#{batch}/f_f3-f4"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_F3", authorization).print
        puts IpcommerceTransaction.new("#{batch}_F4", capture).print
      end
    end
    
    context 'F5' do
      let(:amount) { 19.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111') }
      use_vcr_cassette "#{batch}/f_f5"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_F5", purchase).print
      end
    end
    
    context 'F6' do
      let(:amount) { 87.00 }
      let(:credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :cvv_number => '111') }
      use_vcr_cassette "#{batch}/f_f6"

      it "ouputs the result" do
        puts IpcommerceTransaction.new("#{batch}_F6", purchase).print
      end
    end
  end

  context 'Secure Card Data Tokenization Tests' do
    let(:i1_authorization) { gateway.authorize(nil, i1_credit_card, 17.00, options) }
    let(:i1_credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :street_address => '1000 1st Av') }
    let(:i2_authorization) { gateway.authorize(nil, i2_credit_card, 18.00, options) }
    let(:i2_credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454', :cvv_number => '111') }
    let(:i3_authorization) { gateway.authorize(nil, i3_credit_card, 19.00, options) }
    let(:i3_credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456', :cvv_number => '1111') }
    let(:i4_purchase) { gateway.purchase(nil, i1_credit_card, 16.00, options.merge(:transaction_id => i1_authorization.id)) }
    let(:i5_purchase) { gateway.purchase(nil, i2_credit_card, 18.00, options.merge(:transaction_id => i2_authorization.id)) }
    let(:i6_purchase) { gateway.purchase(nil, i3_credit_card, 31.83, options.merge(:transaction_id => i3_authorization.id)) }
    
    use_vcr_cassette "#{batch}/i1-i6"
    it "outputs the results" do
      puts IpcommerceTransaction.new("#{batch}_I1", i1_authorization).print
      puts IpcommerceTransaction.new("#{batch}_I2", i2_authorization).print
      puts IpcommerceTransaction.new("#{batch}_I3", i3_authorization).print
      puts IpcommerceTransaction.new("#{batch}_I4", i4_purchase).print
      puts IpcommerceTransaction.new("#{batch}_I5", i5_purchase).print
      puts IpcommerceTransaction.new("#{batch}_I6", i6_purchase).print
    end
  end
  
  context 'Transaction Management Services (TMS)' do
    let(:t1_purchase) { gateway.purchase(nil, t1_credit_card, 30.00, options) }
    let(:t1_credit_card) { Factory.build(credit_card_factory, :card_number => '4111111111111111', :postal_code => '10101', :cvv_number => '111') }
    let(:t2_refund) { gateway.refund(t1_purchase.id, 30.00, options) }

    let(:t3_authorization) { gateway.authorize(nil, t3_credit_card, 32.00, options) }
    let(:t3_credit_card) { Factory.build(credit_card_factory, :card_number => '5454545454545454', :postal_code => '10101', :cvv_number => '111') }
    let(:t4_void) { gateway.void(t3_authorization.id, options) }

    let(:t5_authorization) { gateway.authorize(nil, t5_credit_card, 33.00, options) }
    let(:t5_credit_card) { Factory.build(credit_card_factory, :card_number => '6011000995504101', :postal_code => '10101', :cvv_number => '111') }

    let(:t6_purchase) { gateway.purchase(nil, t6_credit_card, 34.00, options) }
    let(:t6_credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456', :postal_code => '10101', :cvv_number => '111') }

    let(:t7_authorization) { gateway.authorize(nil, t7_credit_card, 34.00, options) }
    let(:t7_credit_card) { Factory.build(credit_card_factory, :card_number => '371449635398456', :postal_code => '10101', :cvv_number => '111') }

    use_vcr_cassette "#{batch}/t"
    
    context 'setup' do
      use_vcr_cassette "#{batch}/t-setup"
      it "clears captures" do
        gateway.capture_all(options)
      end
    end

    it "outputs the result" do
      puts IpcommerceTransaction.new("#{batch}_T1", t1_purchase).print
      puts IpcommerceTransaction.new("#{batch}_T2", t2_refund).print 
      puts IpcommerceTransaction.new("#{batch}_T3", t3_authorization).print 
      puts IpcommerceTransaction.new("#{batch}_T4", t4_void).print
      puts IpcommerceTransaction.new("#{batch}_T5", t5_authorization).print
      puts IpcommerceTransaction.new("#{batch}_T6", t6_purchase).print
      puts IpcommerceTransaction.new("#{batch}_T7", t7_authorization).print

      gateway.query_batch
      gateway.query_transactions_summary
      gateway.query_transactions_families({ :transaction_ids => [t5_authorization.id]})
      gateway.query_transaction_details({ :transaction_ids => [t1_purchase.id]})
    end
  end
end
