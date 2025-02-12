require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

# Game state
$cookies = 0.0
$click_value = 1
$cursors = 0
$cursor_cost = 15
$cursor_cps = 0.1
$grandmas = 0
$grandma_cost = 100
$grandma_cps = 1

# Auto-generate cookies
Thread.new do
  loop do
    $cookies += ($cursors * $cursor_cps) + ($grandmas * $grandma_cps)
    sleep 1
  end
end

# Helper function (no change)
def game_state
  {
    cookies: $cookies.to_i,
    cursor_cost: $cursor_cost,
    cursors: $cursors,
    cursor_cps: $cursor_cps,
    grandma_cost: $grandma_cost,
    grandmas: $grandmas,
    grandma_cps: $grandma_cps
  }
end

get '/' do
  erb :index  # Serve the initial HTML
end

# NEW ROUTE:  Get the game state as JSON
get '/state' do
  content_type :json
  game_state.to_json
end

post '/click' do
  $cookies += $click_value
  content_type :json
  game_state.to_json
end

post '/buy_cursor' do
  if $cookies >= $cursor_cost
    $cookies -= $cursor_cost
    $cursors += 1
    $cursor_cost = ($cursor_cost * 1.15).to_i
  end
  content_type :json
  game_state.to_json
end

post '/buy_grandma' do
  if $cookies >= $grandma_cost
    $cookies -= $grandma_cost
    $grandmas += 1
    $grandma_cost = ($grandma_cost * 1.15).to_i
  end
  content_type :json
  game_state.to_json
end