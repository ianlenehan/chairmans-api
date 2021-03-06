Rails.application.routes.draw do
  get 'players' => 'players#show'
  get 'results' => 'rounds#show'
  get 'full_results' => 'rounds#full_results'
  post 'results' => 'rounds#create'
  get 'player_scores' => 'players#player_scores'
end
