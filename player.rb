class Player
	def initialize(game_window)
		@game_window = game_window
		@icon = Gosu::Image.new(@game_window, "images/player1.png", true)
		@x = 260
		@y = 600
		@icon2 = Gosu::Image.new(@game_window, "images/player1dead.png", true)
		@icon3 = Gosu::Image.new(@game_window, "images/player1dead2.png", true)
		@icon4 = Gosu::Image.new(@game_window, "images/player1live.png", true)
		@icon5 = Gosu::Image.new(@game_window, "images/player1000points.png", true)
		@icon6 = Gosu::Image.new(@game_window, "images/player300points.png", true)
		@icon7 = Gosu::Image.new(@game_window, "images/player100points.png", true)
		@killed = false
		@killed2 = false
		@live1 = false
		@point1 = false
		@point2 = false
		@point3 = false
		@lives = 3
		@hit = 0
	end
	
	def draw
		if @killed 
			@icon2.draw(@x, @y, 3)
		else
			@icon.draw(@x, @y, 1)
		end
		
		if @killed2 
			@icon3.draw(@x, @y, 3)
		else
			@icon.draw(@x, @y, 1)
		end
		
		if @live1 
			@icon4.draw(@x, @y, 3)
		else
			@icon.draw(@x, @y, 1)
		end
		
		
		
		if @point1 
			@icon5.draw(@x, @y, 4)
		else
			@icon.draw(@x, @y, 1)
		end
		
		if @point2 
			@icon6.draw(@x, @y, 4)
		else
			@icon.draw(@x, @y, 1)
		end
		
		if @point3 
			@icon7.draw(@x, @y, 4)
		else
			@icon.draw(@x, @y, 1)
		end
		
	end
	
	def move_left
		if @x < 10
			@x = 0
		else
			@x = @x - 10
		end
	end
	
	def move_right
		if @x > (@game_window.width - 60)
			@x = @game_window.width - 50
		else
		@x = @x + 10
		end
	end
	
	def move_down
		if @y > (@game_window.height - 60)
			@y = @game_window.height - 50
		else
		@y = @y + 10
		end
	end
	
	def move_up
		if @y < 10
			@y = 0
		else
		@y = @y - 10 
		end
	end
	
	def hit_by? (balls)
		if balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 50}
			@killed = true
		else
			@killed = false
		end	
		
		if @killed == true
			@lives = @lives - 1
			@hit = @hit + 1
		end
	end
	
	def hit_by2? (balls2)
		if balls2.any? {|ball2| Gosu::distance(@x, @y, ball2.x, ball2.y) < 50}
			@killed2 = true
		else
			@killed2 = false
		end
		
		if @killed2 == true
			@lives = @lives - 2	
			@hit = @hit + 2
		end
	end	
	
	def hit_by3? (live)
		if live.any? {|live| Gosu::distance(@x, @y, live.x, live.y) < 50}
			@live1 = true
		else
			@live1 = false
		end
		
		if @live1 == true
			@lives = @lives + 1	
			@hit = @hit + 1
		end
	end	
	
	
	def hit_by_Points1000? (points1000)
		if points1000.any? {|points1000| Gosu::distance(@x, @y, points1000.x, points1000.y) < 50}
			@point1 = true
			points1000.any? {|points1000| Gosu::distance(@x, @y, points1000.x, points1000.y) < 50}
		else
			@point1 = false
		end
	end
	
	def hit_by_Points300? (points300)
		if points300.any? {|points300| Gosu::distance(@x, @y, points300.x, points300.y) < 50}
			@point2 = true
			points300.any? {|points300| Gosu::distance(@x, @y, points300.x, points300.y) < 50}
		else
			@point2 = false
		end
	end

	def hit_by_Points100? (points100)
		if points100.any? {|points100| Gosu::distance(@x, @y, points100.x, points100.y) < 50}
			@point3 = true
			points100.any? {|points100| Gosu::distance(@x, @y, points100.x, points100.y) < 50}
		else
			@point3 = false
		end
	end
	

	
			def hit_amount
				@hit
			end
			
			def x
				@x
			end
				
			def y
				@y 
			end
			
			def lives
				@lives
			end
			
			def hit_ball!
				if @hit >= 0
					@hit = 1
				end
			end
			
			def hit_ball2!
				if @hit >= 0
					@hit = 2
				end
			end
			
			def hit_live!
				if @hit >= 0
					@hit = 1
				end
			end
			
			
	
	
	def reset!
		@y = 600
		@x = 260
		if @lives <= 0
			@lives =3
			@hit = 0
		end
		
		
	end
							
	
end