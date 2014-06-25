require 'spec_helper'
require 'ocr_parser'

describe OcrParser do
  it 'should parse a single 000000000 entry' do
    number = " _  _  _  _  _  _  _  _  _\n" +
             "| || || || || || || || || |\n" +
             "|_||_||_||_||_||_||_||_||_|\n\n"
    parsed_number = OcrParser.parse_entry(number)
    expect(parsed_number).to eq '000000000'
  end
end
