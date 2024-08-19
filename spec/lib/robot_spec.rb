require 'robot'

RSpec.describe Robot do
  let(:robot) { Robot.new }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:f) { :NORTH }

  describe '#place' do
    subject { robot.place(x, y, f) }

    it do
      expect(subject).to be(true)
      expect(robot.unplaced?).to be(false)
      expect(robot.x).to eq(x)
      expect(robot.y).to eq(y)
      expect(robot.f).to eq(f)
    end

    shared_examples 'it returns false and keeps x, y and f as nil' do
      it do
        expect(subject).to be(false)
        expect(robot.unplaced?).to be(true)
        expect(robot.x).to be_nil
        expect(robot.y).to be_nil
        expect(robot.f).to be_nil
      end
    end

    context 'when x is below lowerbound' do
      let(:x) { -1 }

      it { is_expected.to be(false) }
    end

    context 'when x is above upperbound' do
      let(:x) { Robot::DEFAULT_TABLE_WIDTH }
      include_examples 'it returns false and keeps x, y and f as nil'
    end

    context 'when y is below lowerbound' do
      let(:y) { -1 }

      it { is_expected.to be(false) }
    end

    context 'when y is above upperbound' do
      let(:y) { Robot::DEFAULT_TABLE_HEIGHT }

      include_examples 'it returns false and keeps x, y and f as nil'
    end

    context 'when f is invalid' do
      let(:f) { :NORTHWEST }

      include_examples 'it returns false and keeps x, y and f as nil'
    end

    context 'when x, y and f are all invalid' do
      let(:x) { -10 }
      let(:y) { Robot::DEFAULT_TABLE_HEIGHT + 5 }
      let(:f) { :SOUTHEAST }
    end
  end

  context 'when robot has not been placed yet' do
    it do
      expect(robot.unplaced?).to be(true)
      expect(robot.table_width).to eq(Robot::DEFAULT_TABLE_WIDTH)
      expect(robot.table_height).to eq(Robot::DEFAULT_TABLE_HEIGHT)
      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.f).to be_nil
    end

    describe '#move/#left/#right' do
      it 'returns false' do
        expect(robot.move).to be(false)
        expect(robot.left).to be(false)
        expect(robot.right).to be(false)
      end
    end
  end

  context 'when robot has been placed' do
    before { robot.place(x, y, f) }

    describe '#move' do
      shared_examples 'it fails and does not update x, y nor f' do
        it do
          expect(robot.move).to be(false)
          expect(robot.x).to eq(x)
          expect(robot.y).to eq(y)
          expect(robot.f).to eq(f)
        end
      end

      context 'when robot is at bottom left corner' do
        context 'when f is NORTH' do
          it do
            expect(robot.move).to be(true)
            expect(robot.x).to eq(0)
            expect(robot.y).to eq(1)
            expect(robot.f).to eq(:NORTH)
          end
        end

        context 'when f is EAST' do
          let(:f) { :EAST }

          it do
            expect(robot.move).to be(true)
            expect(robot.x).to eq(1)
            expect(robot.y).to eq(0)
            expect(robot.f).to eq(:EAST)
          end
        end

        context 'when f is SOUTH' do
          let(:f) { :SOUTH }

          include_examples 'it fails and does not update x, y nor f'
        end

        context 'when f is WEST' do
          let(:f) { :WEST }

          include_examples 'it fails and does not update x, y nor f'
        end
      end

      context 'when robot is at top right corner (x = 0, y = 0)' do
        let(:x) { robot.table_width - 1 }
        let(:y) { robot.table_height - 1 }

        context 'when f is NORTH' do
          include_examples 'it fails and does not update x, y nor f'
        end

        context 'when f is EAST' do
          let(:f) { :EAST }

          include_examples 'it fails and does not update x, y nor f'
        end

        context 'when f is SOUTH' do
          let(:f) { :SOUTH }

          it do
            expect(robot.move).to be(true)
            expect(robot.x).to eq(x)
            expect(robot.y).to eq(y - 1)
            expect(robot.f).to eq(:SOUTH)
          end
        end

        context 'when f is WEST' do
          let(:f) { :WEST }

          it do
            expect(robot.move).to be(true)
            expect(robot.x).to eq(x - 1)
            expect(robot.y).to eq(y)
            expect(robot.f).to eq(:WEST)
          end
        end
      end
    end

    describe '#left' do
      it do
        expect(robot.f).to eq(:NORTH)

        expect(robot.left).to be(true)
        expect(robot.f).to eq(:WEST)

        expect(robot.left).to be(true)
        expect(robot.f).to eq(:SOUTH)

        expect(robot.left).to be(true)
        expect(robot.f).to eq(:EAST)

        expect(robot.left).to be(true)
        expect(robot.f).to eq(:NORTH)
      end
    end

    describe '#right' do
      it do
        expect(robot.f).to eq(:NORTH)

        expect(robot.right).to be(true)
        expect(robot.f).to eq(:EAST)

        expect(robot.right).to be(true)
        expect(robot.f).to eq(:SOUTH)

        expect(robot.right).to be(true)
        expect(robot.f).to eq(:WEST)

        expect(robot.right).to be(true)
        expect(robot.f).to eq(:NORTH)
      end
    end

    describe '#report' do
      it { expect { robot.report }.to output("#{robot.x},#{robot.y},#{robot.f}\n").to_stdout_from_any_process }
    end
  end
end
