# frozen_string_literal: true

# # #
class Points100
  def initialize(game_window)
    @game_window = game_window
    @icon = Gosu::Image.new(@game_window, 'images/points100.png', true)
    reset!
  end

  def update
    if @y > @game_window.height
      reset!
    else
      @y += 8
    end
  end

  def draw
    @icon.draw(@x, @y, 2)
  end

  def x
    @x
  end

  def y
    @y
  end

  def reset!
    @y = -1000
    @x = rand(@game_window.width) - 50
    @x = 0 if @x <= 0
  end
end
