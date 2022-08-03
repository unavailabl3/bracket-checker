require 'rails_helper'

RSpec.describe ExpressionsCheckService do
  context 'valid input parameters' do
    let(:single_input) { "[]" }
    let(:multiline_input) { "[]\n[]" }
    it 'returns detailed result (Hash) for one expression' do
        expected_result = {
            expression: single_input,
            valid: true
        }
        result = described_class.call(single_input)
        expect(result).to eq(expected_result)
    end

    it 'returns detailed result (Array) for many expressions' do
        expected_result = [
            { expression: single_input, valid: true },
            { expression: single_input, valid: true }
        ]
        result = described_class.call(multiline_input)
        expect(result).to eq(expected_result)
    end

    it 'returns error message for invalid input' do
        result = described_class.call("[")
        expect(result).to have_key(:error)
    end

    it 'returns short result (Boolean) for one expression due to detailed parameter' do
        result = described_class.call(single_input, false)
        expect(result).to eq(true)
    end

    it 'returns short result (Array) for many expressions due to detailed parameter' do
        result = described_class.call(multiline_input, false)
        expect(result).to eq([true, true])
    end

    it 'is valid for empty string' do
        result = described_class.call("", false)
        expect(result).to eq(true)
    end

    it 'is valid fot set of inputs' do
        input_set = ["[]","([])","([(){}])","[<>({}){}[([])<>]]","((((((()))))))"]
        expected_response = Array.new(input_set.size, true)

        result = described_class.call(input_set.join("\n"), false)
        expect(result).to eq(expected_response)
    end

    it 'checks non-bracket symbols absence' do
        result = described_class.call("[a]")
        expect(result[:valid]).to eq(false)
        expect(result[:error]).to eq('Expression contains invalid symbols')
    end

    it 'is invalid fot set of inputs' do
        input_set = ["]()","[(])","[()","[", "(", "<", "{"]
        expected_response = Array.new(input_set.size, false)

        result = described_class.call(input_set.join("\n"), false)
        expect(result).to eq(expected_response)
    end
  end

  context 'invalid input parameters' do
    it 'raises error if input type is invalid' do
        expect { described_class.call(nil) }.to raise_error(TypeError)
    end
  end
end