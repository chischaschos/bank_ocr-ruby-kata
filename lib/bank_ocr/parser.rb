module BankOcr
  class Parser
    # The main interface of the library is the **BankOcr::Parser.process** method.
    # The file processing is achieved in three steps:
    #
    # 1. First **parse_file**
    # 2. Second **add_entry_validation** for each *parsed_number*
    # 3. and finally **save_output**
    #
    def self.process(file_name)
      parsed_numbers = parse_file(file_name)
      parsed_numbers.each do |parsed_number|
        add_entry_validation!(parsed_number)
      end

      save_output(file_name, parsed_numbers)
    end

    # **add_entry_validation** means to check if a *parsed_number* contains
    # an **AccountNumber.error** and if there is then concatenate it to the
    # *parsed_number*
    def self.add_entry_validation!(parsed_number)
      error = AccountNumber.error(parsed_number)
      parsed_number <<  ' ' + error if error
    end

    # **save_output** of the given *file_name* file in another file name whose
    # name is the same as the input *file_name* with the *output* word inserted
    # before the file extension.
    def self.save_output(file_name, parsed_numbers)
      output_file = file_name.gsub(/(.+)\.txt$/, '\1_output.txt')
      file = File.open(output_file, 'w')
      file.write(parsed_numbers.join("\n"))
      file.close
    end

    # Back to **parse_file** identified by *file_name*,  we read all the lines in the file
    # as an array and then take slices of 4 lines.
    # Next we want to pass each *slice* to **parse_entry**
    def self.parse_file(file_name)
      IO.readlines(file_name).each_slice(4).map { |slice| parse_entry(slice) }
    end

    # A *slice* or *lines_entry* is parsed by obtaining the **numbers_per_entry**
    # in a *lines_entry* and then just concatenating them
    def self.parse_entry(lines_entry)
      numbers_per_entry(lines_entry).reduce(String.new) do |number, number_parser|
        number << number_parser.parse
        number
      end
    end

    # To obtain the **numbers_per_entry** on a *lines_entry* we follow the next steps:
    #
    # 1. Take the first 3 lines that contain the actual characters representing a number.
    # 2. Extract **each_number_section** within each of the 3 lines
    # 3. Assign the *number segment* corresponding to each number to a **NumberParser**
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

    # Getting **each_number_section** in a *line* means extracting *chains of
    # exactly 3 characters* and then **yield** them with the *index* where it
    # was found so they can be assigned to a specific **NumberParser**
    def self.each_number_section(line)
      section_pattern = /.{3}/

      line.scan(section_pattern).each_with_index do |number_section, index|
        yield number_section, index
      end
    end
  end
end
