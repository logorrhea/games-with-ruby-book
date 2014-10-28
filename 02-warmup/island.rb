require 'gosu'
require 'gosu_tiled'

class GameWindow < Gosu::Window

    MAP_FILE = File.join(File.dirname(__FILE__), 'island.json')
    SPEED = 5

    def initialize
        super(640, 480, false)
        @map = Gosu::Tiled.load_json(self, MAP_FILE)
        @x = @y = 0
        @first_render = true
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end

    def update
        @x -= SPEED if button_down?(Gosu::KbLeft)
        @x += SPEED if button_down?(Gosu::KbRight)
        @y -= SPEED if button_down?(Gosu::KbUp)
        @y += SPEED if button_down?(Gosu::KbDown)
        self.caption = "#{Gosu.fps} FPS. Use arrow keys to pan"
    end

end
