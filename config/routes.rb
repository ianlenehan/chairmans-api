Rails.application.routes.draw do
  get 'results' => 'rounds#show'
  post 'results' => 'rounds#create'
  get 'player_scores' => 'players#player_scores'
end
