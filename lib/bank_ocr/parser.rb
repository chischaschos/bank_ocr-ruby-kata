module BankOcr
  class Parser
    def self.add_entry_validation!(parsed_number)
      error = AccountNumber.error(parsed_number)
      parsed_number <<  ' ' + error if error
    end

    def self.each_entry(lines)
      lines.each_slice(4).map { |slice| yield slice }
    end

    def self.each_number_section(line)
      section_pattern = /.{3}/

      line.scan(section_pattern).each_with_index do |number_section, index|
        yield number_section, index
      end
    end

    def self.numbers_per_entry(lines_entry)
      numbers = []
      line = lines_entry.first(3)

      3.times do |line_index|
        each_number_section(line[line_index]) do |number_section, column|
          numbers[column] ||= NumberParser.new
          numbers[column] << number_section
        end
      end

      numbers
    end

    def self.parse_entry(lines_entry)
      numbers_per_entry(lines_entry).reduce(String.new) do |number, number_parser|
        number << number_parser.parse
        number
      end
    end

    def self.parse_file(file_name)
      IO.readlines(file_name).each_slice(4).map { |slice| parse_entry(slice) }
    end

    def self.process(file_name)
      parsed_numbers = parse_file(file_name)
      parsed_numbers.each do |parsed_number|
        add_entry_validation!(parsed_number)
      end

      save_output(file_name, parsed_numbers)
    end

    def self.save_output(file_name, parsed_numbers)
      output_file = file_name.gsub(/(.+)\.txt$/, '\1_output.txt')
      file = File.open(output_file, 'w')
      file.write(parsed_numbers.join("\n"))
      file.close
    end
  end
end
