class RoundsController < ApplicationController
  protect_from_forgery with: :null_session

  def show
    render json: { results: results, players: Player.all, round_counts: round_counts }
  end

  def create
    create_rounds
    create_result
    render plain: 'success'
  end

  def full_results
    result_rounds = results.map do |result|
      rounds = Round.where(round_date: result.round_date)
      { result: result, scores: rounds }
    end
    render json: result_rounds
  end

  private

  def from_date
    # params[:from].to_date
    return "2018-12-31"
  end

  def results
    results = Result.where('round_date > ?', from_date)
    results.order(:round_date).reverse
  end

  def round_counts
    Player.all.map do |player|
      count = player.rounds.where('round_date > ?', from_date).where('score > ?', 0).count
      {player.nick_name => count}
    end
  end

  def create_rounds
    scores = params[:scores]
    scores.each do |score|
      if score != ''
        player = Player.find_by(nick_name: score[0])
        Round.create(
          round_date: round_date,
          player_id: player.id,
          score: score[1]['score'].to_i
        )
      end
    end
  end

  def create_result
    Result.create(
      winner: winner.id,
      loser: loser.id,
      round_date: round_date
    )
  end

  def round_date
    params[:roundDate].to_date
  end

  def winner
    Player.find_by(nick_name: params[:winner])
  end

  def loser
    Player.find_by(nick_name: params[:hatHolder])
  end
end
