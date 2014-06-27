module BankOcr
  class AccountNumber
    def self.error(number_string)
      return 'ILL' if illegible?(number_string)
      return 'ERR' unless valid_checksum?(number_string)
    end

    def self.illegible?(number_string)
      !!(number_string =~ /\?/)
    end

    def self.valid_checksum?(number_string)
      index = 1

      number_string.reverse.chars.reduce(0) do |sum, number|
        sum += number.to_i * index
        index += 1
        sum
      end % 11 == 0
    end
  end
end
