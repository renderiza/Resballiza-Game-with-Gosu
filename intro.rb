class Intro
	def initialize(game_window)
		@game_window = game_window
		@renderiza_studio = Gosu::Image.new(@game_window, "images/intro_renderiza_studio.png", true)
		@presents = Gosu::Image.new(@game_window, "images/intro_presents.png", true)
		@resballiza = Gosu::Image.new(@game_window, "images/intro_resballiza.png", true)
		#@resballiza2 = Gosu::Image.new(@game_window, "images/intro_resballiza2.png", true)
		@x = 0
		@y = 0
	end
	
	
	def draw
		@renderiza_studio.draw(@x,@y,100)
	end	
	
	def draw2
		@presents.draw(@x,@y,100)
	end

	def draw3
		@resballiza.draw(@x,@y,100)
	end		
end