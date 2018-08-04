class Ball2
	def initialize (game_window)
		@game_window = game_window
		@icon = Gosu::Image.new(@game_window, "images/ball2.png", true)
		reset!
	end
	
	def update
	
		if @y > @game_window.height
			reset!
		else
		@y = @y + 5
		end
	end
	
	def draw
		@icon.draw(@x,@y,3)
	end
	
	def x
		@x
	end
		
	def y
		@y
	end
	
	def reset!
		@y = 0
		@x = rand(@game_window.width) - 50
		if @x <= 0 
			@x = 0
		end
	end
		
	
end