class Background
	def initialize(game_window)
		@game_window = game_window
		@icon = Gosu::Image.new(@game_window, "images/background.png", true)
		@x = 0
		@y = 0
	end
	
	
	def draw
		@icon.draw(@x,@y,0)
	end	
	
end