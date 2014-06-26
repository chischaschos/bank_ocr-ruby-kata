require 'spec_helper'

describe BankOcr::AccountNumber do

  context 'when the numbers are valid' do
    let(:numbers) { [ 711111111, 123456789, 490867715 ] }

    it 'should validate account numbers' do
      numbers.each do |number|
        expect(BankOcr::AccountNumber.valid?(number.to_s)).to be_true
      end
    end
  end

  context 'when the numbers are invalid' do
    let(:numbers) { [ 888888888, 490067715, 490067715 ] }

    it 'should validate account numbers' do
      numbers.each do |number|
        expect(BankOcr::AccountNumber.valid?(number.to_s)).to be_false
      end
    end
  end
end
