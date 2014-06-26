module BankOcr
  class AccountNumber
    def self.valid?(number_string)
      index = 1

      number_string.reverse.chars.reduce(0) do |sum, number|
        sum += number.to_i * index
        index += 1
        sum
      end % 11 == 0
    end
  end
end
