module BankOcr
  class Parser
    def self.parse_entry(string_entry)
      split_numbers(string_entry).reduce(String.new) do |number, number_parser|
        number << number_parser.to_s
        number
      end
    end

    def self.split_numbers(string_entry)
      numbers = []
      lines = string_entry.chop.split("\n")

      3.times do |line_index|
        lines[line_index].scan(/.{3}/).each_with_index do |number_section, index|
          numbers[index] ||= NumberParser.new
          numbers[index] << number_section
        end
      end

      numbers
    end
  end
end
