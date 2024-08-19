# frozen_string_literal: true

describe do
  let(:greeting) { 'Enter a PLACE command in the format "PLACE X,Y,F" to place the robot (e.g. PLACE 0,0,NORTH):' }
  let(:expected_output) { "#{greeting}\n#{report}\n" }

  subject(:main) { system "ruby main.rb test_files/test#{test_i}.txt" }

  context 'with test 1' do
    let(:test_i) { 1 }
    let(:report) { '0,1,NORTH' }

    it { expect { main }.to output(expected_output).to_stdout_from_any_process }
  end

  context 'with test 2' do
    let(:test_i) { 2 }
    let(:report) { '0,0,WEST' }

    it { expect { main }.to output(expected_output).to_stdout_from_any_process }
  end

  context 'with test 3' do
    let(:test_i) { 3 }
    let(:report) { '3,3,NORTH' }

    it { expect { main }.to output(expected_output).to_stdout_from_any_process }
  end
end
