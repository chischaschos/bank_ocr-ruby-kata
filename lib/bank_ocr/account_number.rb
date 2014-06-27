module BankOcr
  class AccountNumber
    # The main interface of the **AccountNumber** abstraction is the **error**
    # method.
    # **error** receives a *number_string* parameter and returns a *3 characters
    # error code* or *nil* when there are not any errors.
    def self.error(number_string)
      return 'ILL' unless readable?(number_string)
      return 'ERR' unless valid_checksum?(number_string)
    end

    # The error method checks if a *number_string* is **readable?** or not.
    def self.readable?(number_string)
      (number_string =~ /\?/).nil?
    end

    # The error method also checks if *number_string* has a **valid_checksum?**
    # or not.
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
