require 'rails_helper'

RSpec.describe Accounts::TransfersController, type: :controller do
  describe "PUT update " do
    let(:weekday_available_time) { Timecop.freeze(Time.local(2022, 04, 22, 10, 5, 0)) }
    let(:weekend) { Timecop.freeze(Time.local(2022, 04, 23, 10, 5, 0)) }
    let(:weekday_after_18) { Timecop.freeze(Time.local(2022, 04, 22, 18, 5, 0)) }
    let(:weekday_bofere_9) { Timecop.freeze(Time.local(2022, 04, 22, 8, 5, 0)) }

    context "When the transaction has no FEE" do
      let(:account) { create_list(:account, 2, :with_user, balance: 10.to_f) }
      let(:balance) { 5 }

      it 'R$ 5 per transfer' do
        weekday_available_time

        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.second.id).balance).to eq(10.to_f)
      end

      it 'remove value' do
        weekday_available_time

        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.first.id).balance).to eq(5.to_f)
      end
    end

    context "When the transaction has FEE" do
      let(:account) { create_list(:account, 2, :with_user, balance: 10.to_f) }
      let(:balance) { 1001}

      it 'R$ 10 above R$ 1000 and R$ 5 per transfer' do
        weekday_available_time

        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.second.id).balance).to eq(996.to_f)
      end

      it 'R$ 7 because are after 18pm' do
        weekday_after_18
  
        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.second.id).balance).to eq(994.to_f)
      end

      it 'R$ 7 because are before 9am' do
        weekday_bofere_9
  
        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.second.id).balance).to eq(994.to_f)
      end

      it 'R$ 7 because is weekend' do
        weekend
  
        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.second.id).balance).to eq(994.to_f)
      end
    end

    context "When transaction Failed" do
      let(:account) { create_list(:account, 2, :with_user, balance: 10.to_f) }
      let(:balance) { 15 }
  
      it 'return 0.0 balance' do
        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '123456' }

        expect(Account.find(account.first.id).balance).to eq(0.0)
      end

      it 'return password error' do
        put :update, params: { id: account.first.id, account_recive_id: account.second.id, balance: balance, password: '1234567' }

        expect(response).to raise_error("something bad happened!")
      end
    end
  end
end
