require 'spec_helper'

describe BankOcr::Parser do
  subject(:bank_ocr_parser) { BankOcr::Parser }

  let(:fixtures_folder) { File.join(File.realpath(File.dirname(__FILE__)), '..', 'fixtures') }

  let(:input_file_name_1) { File.join(fixtures_folder, 'test_numbers_1.txt') }

  let(:input_file_name_2) { File.join(fixtures_folder, 'test_numbers_2.txt') }

  let(:output_file_name_2) { File.join(fixtures_folder, 'test_numbers_2_output.txt') }

  describe '#parse_file' do
    it 'should parse a file with multiple entries' do
      expect(bank_ocr_parser.parse_file(input_file_name_1)).to eq [
        '000000000',
        '111111111',
        '222222222',
        '333333333',
        '444444444',
        '555555555',
        '666666666',
        '777777777',
        '888888888',
        '999999999',
        '123456789',
      ]

      expect(bank_ocr_parser.parse_file(input_file_name_2)).to eq [
        '457508000',
        '664371495',
        '86110??36',
        '000000051',
        '49006771?',
        '1234?678?'
      ]
    end
  end

  describe '#process_file' do
    before { File.unlink(output_file_name_2) if File.exists?(output_file_name_2) }

    it 'should parse and validate a file dumping its results to an output file' do
      bank_ocr_parser.process(input_file_name_2)
      expect(File.exists?(output_file_name_2)).to be_true
    end
  end

  describe '#each_entry' do
    context 'with a perfect file' do
      it 'should read each 4 lines as an entry' do
        file = File.join(File.realpath(File.dirname(__FILE__)), '..', 'fixtures', 'test_numbers_1.txt')
        lines = IO.readlines(file)
        bank_ocr_parser.each_entry(lines) do |entry|
          expect(entry).to have(4).items
        end
      end
    end
  end

  describe '#parse_entry' do
    let(:series) do
      {
        [
          " _  _  _  _  _  _  _  _  _ ",
          "| || || || || || || || || |",
          "|_||_||_||_||_||_||_||_||_|",
          ""
        ] => '000000000',
        [
          "                           ",
          "  |  |  |  |  |  |  |  |  |",
          "  |  |  |  |  |  |  |  |  |",
          ""
        ] => '111111111',
        [
          " _  _  _  _  _  _  _  _  _ ",
          " _| _| _| _| _| _| _| _| _|",
          "|_ |_ |_ |_ |_ |_ |_ |_ |_ ",
          ""
        ] => '222222222',
        [
          " _  _  _  _  _  _  _  _  _ ",
          " _| _| _| _| _| _| _| _| _|",
          " _| _| _| _| _| _| _| _| _|",
          ""
        ] => '333333333',
        [
          "                           ",
          "|_||_||_||_||_||_||_||_||_|",
          "  |  |  |  |  |  |  |  |  |",
          ""
        ] => '444444444',
        [
          " _  _  _  _  _  _  _  _  _ ",
          "|_ |_ |_ |_ |_ |_ |_ |_ |_ ",
          " _| _| _| _| _| _| _| _| _|",
          "",
        ] => '555555555',
        [
          " _  _  _  _  _  _  _  _  _ ",
          "|_ |_ |_ |_ |_ |_ |_ |_ |_ ",
          "|_||_||_||_||_||_||_||_||_|",
          ""
        ] => '666666666',
        [
          " _  _  _  _  _  _  _  _  _ ",
          "  |  |  |  |  |  |  |  |  |",
          "  |  |  |  |  |  |  |  |  |",
          ""
        ] => '777777777',
        [
          " _  _  _  _  _  _  _  _  _ ",
          "|_||_||_||_||_||_||_||_||_|",
          "|_||_||_||_||_||_||_||_||_|",
          ""
        ] => '888888888',
        [
          " _  _  _  _  _  _  _  _  _ ",
          "|_||_||_||_||_||_||_||_||_|",
          " _| _| _| _| _| _| _| _| _|",
          ""
        ] => '999999999',
        [
          "    _  _     _  _  _  _  _ ",
          "  | _| _||_||_ |_   ||_||_|",
          "  ||_  _|  | _||_|  ||_| _|",
          ""
        ] => '123456789',
      }
    end

    it 'should parse each series of numbers' do
      series.each do |numbers_string, number_parsed|
        parsed_number = bank_ocr_parser.parse_entry(numbers_string)
        expect(parsed_number).to eq number_parsed
      end
    end

  end

  describe '#numbers_per_entry' do
    it 'should split a string of numbers into single numbers' do
      number = [
                 " _  _  _  _  _  _  _  _  _ ",
                 "| || || || || || || || || |",
                 "|_||_||_||_||_||_||_||_||_|"
      ]
      numbers  = bank_ocr_parser.numbers_per_entry(number)
      numbers.each do |number_parser|
        expect(number_parser).to be_a BankOcr::NumberParser
        expect(number_parser.parse).to eq '0'
      end
      expect(numbers).to have(9).items
    end
  end
end
