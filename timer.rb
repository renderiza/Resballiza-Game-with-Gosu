# frozen_string_literal: true

# # #
class Timer
  def initialize(game_window, balls, balls2)
    @balls = balls
    @balls2 = balls2
    @game_window = game_window
    @start_time = Time.now
    @every_n_seconds = 5
    @last_recorded_seconds = 0
  end

  def update
    @balls << Ball.new(@game_window) if add_balls?
    @balls2 << Ball2.new(@game_window) if add_balls?
    seconds
  end

  def seconds
    (Time.now - @start_time).to_i
  end

  def add_balls?
    if seconds != @last_recorded_seconds and seconds % @every_n_seconds == 0
      @last_recorded_seconds = seconds
      true
    else
      false
    end
  end

  def reset!
    @start_time = 0
  end
end
