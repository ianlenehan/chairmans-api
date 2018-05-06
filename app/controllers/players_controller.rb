class PlayersController < ApplicationController
  def player_scores
    nick_name = params[:nn]
    from = params[:from]
    player = Player.find_by(nick_name: nick_name)

    rounds = player.rounds.where('round_date > ?', from)
    render json: rounds
  end

  def show
    render json: Player.all
  end
end
