# frozen_string_literal: true

describe do
  subject(:main) { system "ruby main.rb test_files/test#{test_i}.txt" }

  context 'with test 1' do
    let(:test_i) { 1 }

    it { expect { main }.to output("0,1,NORTH\n").to_stdout_from_any_process }
  end

  context 'with test 2' do
    let(:test_i) { 2 }

    it { expect { main }.to output("0,0,WEST\n").to_stdout_from_any_process }
  end

  context 'with test 3' do
    let(:test_i) { 3 }

    it { expect { main }.to output("3,3,NORTH\n").to_stdout_from_any_process }
  end

  context 'with test 4' do
    let(:test_i) { 4 }

    it { expect { main }.to output("3,3,NORTH\n").to_stdout_from_any_process }
  end
end
