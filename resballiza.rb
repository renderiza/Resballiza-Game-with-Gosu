# frozen_string_literal: true

$: << File.expand_path(File.dirname(__FILE__))
require 'rubygems'
require 'gosu'
require 'player'
require 'ball'
require 'ball2'
require 'background'
require 'timer'
require 'live'
require 'points1000'
require 'points300'
require 'points100'
require 'intro'

# # #
class MyGame < Gosu::Window
  def initialize
    super(600, 800, false)
    @player = Player.new(self)
    @balls = 1.times.map { Ball.new(self) }
    # @ball = Ball.new(self)
    @balls2 = 1.times.map { Ball2.new(self) }
    @live = 1.times.map { Live.new(self) }
    @points1000 = 1.times.map { Points1000.new(self) }
    @points300 = 1.times.map { Points300.new(self) }
    @points100 = 1.times.map { Points100.new(self) }
    @running = true
    @pause = false
    @start = false
    @font = Gosu::Font.new(self, 'System', 100)
    @font2 = Gosu::Font.new(self, 'System', 30)
    @background = Background.new(self)
    @intro = Intro.new(self)
    @timer = Timer.new(self, @balls, @balls2)
    @score = 0
    @score2 = 0
    @animation_time = 0
    @newhighscore = 0
    @oldhighscore = 0
    @songs = []
    @songs << Gosu::Song.new('media/impactbombanalog.ogg')
    @song = @songs.first
    @song.play
    @damage_sample = Gosu::Sample.new(self, 'media/zap1.ogg')
    @metaldrop_sample = Gosu::Sample.new(self, 'media/metaldrop_g3.ogg')
    @live_sample = Gosu::Sample.new(self, 'media/sweep_atomheart.ogg')
    @ballsfall_sample = Gosu::Sample.new(self, 'media/stabdubtao1.ogg')
    @balls2fall_sample = Gosu::Sample.new(self, 'media/strikehilden1.ogg')
    @highscore_sample = Gosu::Sample.new(self, 'media/impactbombanalog.ogg')
    @pause_sample = Gosu::Sample.new(self, 'media/woodenfactory.ogg')
    @stop_sample = Gosu::Sample.new(self, 'media/impactyourmission.ogg')
  end

  def button_down(id)
    # Pause
    if id == Gosu::Button::KbP
      if @pause == false
        # This will disable pause if game intro is running
        @pause = true if @score >= 1
        if @running == false
          @pause = false
        elsif @score >= 1
          @pause = true
          @pause_sample.play
        end
      else
        @pause = false
      end
    end

    # Start Game Screen
    if id == Gosu::Button::KbSpace
      #This will work only when game intro is finished
      if @start == false and @animation_time >= 350
        @start = true
        if @running == false
          @start = false
        else
          @start = true 
        end 
      end
    end
  end

  # check if key is pressed
  def update
    @animation_time = @animation_time + 1
    if @start == true
      if @pause == false
        if @running
          @score = @score + 1
          @score2 = @score2 + 1

          if @score == 2
            @balls2 = 1.times.map { Ball2.new(self) }
          end
          if @score == 1000
            @balls2 = 2.times.map { Ball2.new(self) }
          end
          if @score == 5000
            @balls2 = 3.times.map { Ball2.new(self) }
          end
          if @score == 10000
            @balls2 = 4.times.map { Ball2.new(self) }
          end
          if @score == 15000
            @balls2 = 5.times.map { Ball2.new(self) }
          end
          if @score == 20000
            @balls2 = 6.times.map { Ball2.new(self) }
          end
          if @score == 25000
            @balls2 = 7.times.map { Ball2.new(self) }
          end

          if button_down? Gosu::Button::KbLeft
            @player.move_left
          end

          if button_down? Gosu::Button::KbRight
            @player.move_right
          end

          if button_down? Gosu::Button::KbDown
            @player.move_down
          end

          if button_down? Gosu::Button::KbUp
            @player.move_up
          end

          # @ball.update 
          @balls.each { |ball| ball.update } 
          @balls2.each { |ball2| ball2.update }
          @timer.update
          @live.each { |live| live.update }
          @points1000.each { |points| points.update }
          @points300.each { |points| points.update }
          @points100.each { |points| points.update }

          if @player.hit_by? @balls
            if @player.lives > 0
              @damage_sample.play
              restart_game
              @player.hit_ball!
            else
              stop_game!
            end
          end
          if @player.hit_by2? @balls2
            if @player.lives > 0
              @damage_sample.play
              restart_game
              @player.hit_ball2!
            else
              stop_game!
            end
          end
          if @player.hit_by3? @live
            if @player.lives > 0
              @live_sample.play
              @live.each { |live| live.reset! }
              @player.hit_live!
            else
              stop_game!
            end
          end
          if @player.hit_by_Points1000? @points1000
            @metaldrop_sample.play
            @score = @score + 1000
            @points1000.each { |points1000| points1000.reset! }
          end
          if @player.hit_by_Points300? @points300
            @metaldrop_sample.play
            @score = @score + 300
            @points300.each { |points300| points300.reset! }
          end
          if @player.hit_by_Points100? @points100
            @metaldrop_sample.play
            @score = @score + 100
            @points100.each { |points100| points100.reset! }
          end
          @balls.each { |ball| ball.y == 0 and @ballsfall_sample.play }
          @balls2.each { |ball2| ball2.y == 0 and @balls2fall_sample.play }
          if @score >= @newhighscore
          @song.play
          end
          if @newhighscore <= @score
            @newhighscore = @score
          end
        else 
          #the game is currently stoped
          @timer = Timer.new(self, @balls, @balls2)
          if button_down? Gosu::Button::KbEscape
            if @oldhighscore <= @score
              @oldhighscore = @score
            end 
            # If I made @score = 0 the game intro screen would appear temporarly when game is restarted.
            # If you still need @score = 0 then put this in the draw class @intro.draw3 if @animation_time >= 250 and @score <= 0 and @oldhighscore <= 0  
            @score = 1  
            @score2 = 0
            restart_game 
          end
        end
      end
    end
  end

  def draw
    @player.draw
    # @ball.draw 
    @live.each { |live| live.draw }
    @points1000.each { |points1000| points1000.draw }
    @points300.each { |points300| points300.draw }
    @points100.each { |points100| points100.draw }
    @balls.each { |ball| ball.draw }
    @balls2.each { |ball2| ball2.draw }
    @font.draw('Paused', 230,350,3) if @pause == true
    @font.draw('Start Game', 200, 350, 3) if @start == false and @running and @pause == false
    @font2.draw("Press 'Spacebar'", 215, 430, 4) if @start == false and @running and @pause == false
    @font2.draw("Press 'Esc' to Restart Game", 130,350,4) if @running == false
    @background.draw
    @intro.draw if @animation_time <= 150 
    @intro.draw2 if @animation_time >= 150 and @animation_time <= 300                                     
    @intro.draw3 if @animation_time >= 300 and @score <= 0                                        
    @font2.draw("Lives: #{@player.lives}", 480, 10, 4)
    @font2.draw("Score: #{@score}", 10, 10, 4)
    # @font2.draw("Seconds: #{@timer.seconds}", 440, 40, 4)
    # @font2.draw("Animation: #{@animation_time}", 10, 760, 4)
    # @font2.draw("Update: #{@score2}", 10, 770, 4)
    @font2.draw("New Highscore: #{@newhighscore}", 10, 40, 4)
    @font2.draw("Old Highscore: #{@oldhighscore}", 10, 75, 4)
    @font.draw('Try Again', 210, 380, 4) if @running == false
    @font.draw('Awesome', 220, 200, 10) if @score >= 1000 and @score<= 1100
    @font.draw("-#{@player.hit_amount} lives", 230, 350, 10) if @score2 <= 40 and @player.lives == 2
  end

  def stop_game!
    @running = false
    @player.reset!
    @stop_sample.play
  end

  def restart_game
    @running = true
    @balls.each { |ball| ball.reset! }
    @balls2.each { |ball2| ball2.reset! }
    @player.reset!
    @live.each { |live| live.reset! }
    @points1000.each { |points1000| points1000.reset! }
    @points300.each { |points300| points300.reset! }
    @points100.each { |points100| points100.reset! }
    @timer.reset!
    @balls = 1.times.map { Ball.new(self) }
    @timer = Timer.new(self, @balls, @balls2)
    @score2 = 0
  end
end

game = MyGame.new
game.show
