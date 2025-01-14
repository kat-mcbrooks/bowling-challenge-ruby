require 'scorecard'

describe Scorecard do 
  subject(:no_bonus_game) { described_class.new([[4, 5], [3, 2], [3, 1], [2, 1], [4, 4], [0, 0], [0, 0], [0, 0], [0, 0], [10, 2, 10]]) }
  subject(:bonus_game) { described_class.new([[10, 0], [10, 0], [3, 1], [9, 1], [4, 4], [10, 0], [2, 0], [10, 0], [10, 0], [10, 2, 1]]) }
  
  subject(:perfect_game) { described_class.new([[10, 0], [10, 0], [10, 0], [10, 0], [10, 0], [10, 0], [10, 0], [10, 0], [10, 0], [10, 10, 10]]) }
  subject(:all_zero) { described_class.new([[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0, 0]]) }
  
  it 'has 10 frames' do 
    expect(subject.frames.length).to eq 10
  end

  it 'has an array of frames' do 
    expect(subject.frames).to be_a_kind_of(Array)
  end

  describe '#total_score' do 
    it 'calculates correctly when game has strikes and spares' do 
      expect(bonus_game.total_score).to eq 142
    end
    it 'calculates correctly when game has no strikes or spares' do 
      expect(no_bonus_game.total_score).to eq 51
    end
    it 'calculates perfect game score correctly to 300' do 
      expect(perfect_game.total_score).to eq 300
    end
  end
  
  describe '#frame scores' do
    it 'can calculate and display the scores for each frame, if no strikes or spares' do 
      expect(no_bonus_game.frame_scores).to eq [9, 5, 4, 3, 8, 0, 0, 0, 0, 22]
    end 
    it 'can calculate and display the scores for each frame, including bonuses' do 
      expect(bonus_game.frame_scores).to eq [23, 14, 4, 14, 8, 12, 2, 30, 22, 13]
    end 
  
  end

  describe '#bonus' do
    context 'when strike' do 
      it 'if followed by another strike, bonus is 10 plus the 1st roll of the frame that comes after the subsequent strike' do 
        expect(bonus_game.bonus(0)).to eq 13
      end

      it 'is sum of next frame if followed by a non-strike frame' do 
        expect(bonus_game.bonus(1)).to eq 4
        expect(bonus_game.bonus(5)).to eq 2
      end
    end

    context 'when spare' do 
      it 'is 1st roll of the next frame' do 
        expect(bonus_game.bonus(3)).to eq 4
      end
    end

    context 'when neither spare nor strike ' do 
      it 'is zero' do 
        expect(bonus_game.bonus(2)).to eq 0
      end
    end
    context 'when in penultimate frame' do 
      it 'correctly calculates bonus' do 
      end
    end
  end 

  it 'knows if the game score is a perfect game' do 
    expect(perfect_game.perfect_game?).to eq true
  end

  it 'knows if the game score is a gutter game' do 
    expect(all_zero.gutter_game?).to eq true
  end

  describe '#is_spare?' do 
    it 'identifies if frame is a spare' do 
      spare_frame = bonus_game.frames[3]
      expect(bonus_game.spare?(frame: spare_frame)).to eq true
    end
  end

  describe '#is_strike?' do 
  it 'identifies if frame is a strike' do 
    expect(bonus_game.strike?(frame: bonus_game.frames[5])).to be true
  end
end
  
  
end

