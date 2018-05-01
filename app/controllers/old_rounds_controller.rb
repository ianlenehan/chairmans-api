class RoundsController < ApplicationController
  require 'open-uri'

  def golf_scores
    @players = Player.all
    row = 1
    @last_round = most_recent_round
    iterate_each_player(row)

    render json: Player.all, each_serializer: ::PlayerSerializer, from: from_date
  end

  private

  # def iterate_each_player(row)
  #   @players.each do |player|
  #     get_player_scores(player.golflink_number, row)
  #     process_scores(player.golflink_number)
  #   end
  #   if @date > @last_round
  #     # determine_results if is_classic
  #     row += 1
  #     iterate_each_player
  #   end
  # end

  # def get_player_scores(golflink_number, row)
  #   # url = "http://www.golf.org.au/handicap-interstitial/#{golflink_number}/Skip"
  #   url = 'http://www.golf.org.au/handicap-interstitial/2021907337/Skip'
  #   doc = Nokogiri::HTML(open(url))
  #   table = doc.css('.handicap-history-table')
  #   binding.pry
  #   @date_string = table.css('tr')[row].css('.div-rnddetails-sl').text
  #   @score = table.css('tr')[row].css('td')[2].text.delete("\r\n").strip.to_i
  #   @handicap = table.css('tr')[row].css('.hc-tbl-new-hc')
  #                    .text.delete("\r\n")
  #                    .strip.to_i
  #   @slope = table.css('tr')[row].css('td')[5].text.delete("\r\n").strip.to_i
  # end

  # def process_scores(golflink_number)
  #   @date = convert_date(@date_string)
  #
  #   if @date >= from_date && @date != most_recent_round
  #     add_round_for_player(golflink_number, @score, @date)
  #     update_player_handicap(golflink_number, @handicap, @slope)
  #   end
  # end



  def most_recent_round
    dates = Round.all.pluck(:round_date)
    dates.sort.reverse.first
  end

  def add_round_for_player(golflink_number, score, date)
    player = Player.find_by(golflink_number: golflink_number)
    Round.find_or_create_by(round_date: date, score: score, player_id: player.id)
  end

  def update_player_handicap(golflink_number, handicap, slope)
    daily = handicap * slope / 113
    player = Player.find_by(golflink_number: golflink_number)
    player.update(handicap: daily)
  end

  # def is_classic
  #   rounds_of_classic = rounds.where(round_date: @date)
  #   three_or_more_players = rounds_of_classic.length > 3
  #
  #   result = Result.find_by(round_date: @date)
  #   hat_holder = result.loser
  # end

  # def determine_results
  #   immune_player = Player.find_by(immunity: true)
  #   round = Round.where(round_date: @date)
  #   reset_players
  #
  #   best_round = round.order('score DESC').first
  #   best_round.player.update(immunity: true)
  #   winner = best_round.player
  #   worst_round = round.order('score DESC').last
  #   loser = worst_round.player
  #
  #   if worst_round.player == immune_player
  #     second_worst = round.order('score DESC')[round.length - 2]
  #     if second_worst.score <= worst_round.score + 4
  #       second_worst.player.update(hat_holder: true)
  #       loser = second_worst.player
  #     else
  #       worst_round.player.update(hat_holder: true)
  #     end
  #   end
  #   result = Result.find_or_create_by(round_date: @date)
  #   result.update(winner: winner.id, loser: loser.id)
  # end

  def reset_players
    immune_player = Player.find_by(immunity: true)
    immune_player.update(immunity: false) if immune_player
    hat_holder = Player.find_by(hat_holder: true)
    hat_holder.update(hat_holder: false) if hat_holder
  end

  def convert_date(date)
    date_arr = date.split(' ')
    year = '20' + date_arr[2]
    date_arr[2] = year
    date_arr.join(' ').to_date
  end

  def rounds
    Round.where('round_date > ?', from_date)
  end
end
