module BankOcr
  class Parser
    def self.parse_entry(string_entry)
      numbers = split_numbers(string_entry)
    end

    def self.split_numbers(string_entry)
      lines = string_entry.split("\n").first(3)
      numbers = []
      lines[0].scan(/.{3}/).each do |number_section|
        number_parser = NumberParser.new
        number_parser << number_section
        numbers << number_parser
      end

      numbers
    end
  end
end
