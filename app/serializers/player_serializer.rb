class PlayerSerializer < ActiveModel::Serializer
  attributes :id,
             :nick_name,
             :full_name,
             :avatar_url,
             :average_score,
             :handicap,
             :rounds,
             :wins,
             :hats,
             :hat_holder,
             :immunity

  def rounds
    object.rounds.where('round_date > ?', from_date)
  end

  def wins
    results.where(winner: object.id).length
  end

  def hats
    results.where(loser: object.id).length
  end

  def average_score
    scores = rounds.pluck(:score)
    scores.sum / scores.length
  end

  def results
    Result.where('round_date > ?', from_date)
  end

  def from_date
    serialization_options[:from]
  end
end
