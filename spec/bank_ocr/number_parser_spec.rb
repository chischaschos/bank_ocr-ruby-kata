require 'spec_helper'

describe BankOcr::NumberParser do
  subject(:number_parser) { BankOcr::NumberParser.new }

  it 'should create a number' do
    number_parser << ' _ '
    number_parser << '| |'
    number_parser << '|_|'
    expect(number_parser.original).to eq " _ " +
                                         "| |" +
                                         "|_|"
    expect(number_parser.to_s).to eq '0'
  end

  it 'should create a number' do
    number_parser << '   '
    number_parser << '  |'
    number_parser << '  |'
    expect(number_parser.original).to eq "   " +
                                         "  |" +
                                         "  |"
    expect(number_parser.to_s).to eq '1'
  end

end

