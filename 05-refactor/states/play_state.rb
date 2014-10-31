require 'ruby-prof' if ENV['ENABLE_PROFILING']

require_relative '../entities/map'
require_relative '../entities/tank'
require_relative '../entities/camera'
require_relative '../entities/bullet'
require_relative '../entities/explosion'

class PlayState < GameState
    
    def initialize
        @map = Map.new
        @tank = Tank.new(@map)
        @camera = Camera.new(@tank)
        @bullets = []
        @explosions = []
    end

    def update
        bullet = @tank.update(@camera)
        @bullets << bullet if bullet
        @bullets.map(&:update)
        @bullets.reject!(&:done?)
        @camera.update
        update_caption
    end

    def draw
        cam_x, cam_y = @camera.coords
        off_x = $window.width / 2 - cam_x
        off_y = $window.height / 2 - cam_y
        $window.translate(off_x, off_y) do
            zoom = @camera.zoom
            $window.scale(zoom, zoom, cam_x, cam_y) do
                @map.draw(@camera)
                @tank.draw
                @bullets.map(&:draw)
            end
        end
        @camera.draw_crosshair
    end

    def button_down(id)
        if id == Gosu::MsLeft
            bullet = @tank.shoot(*@camera.mouse_coords)
            @bullets << bullet if bullet
        end
        $window.close if id == Gosu::KbQ
        if id == Gosu::KbEscape
            GameState.switch(MenuState.instance)
        end
    end

    def enter
        if ENV['ENABLE_PROFILING']
            RubyProf.start
        end
    end

    def leave
        if ENV['ENABLE_PROFILING']
            result = RubyProf.stop
            printer = RubyProf::FlatPrinter.new(result)
            printer.print(STDOUT)
        end
    end
    
    private

    def update_caption
        now = Gosu.milliseconds
        if now - (@caption_updated_at || 0) > 1000
            $window.caption = 'Tanks Prototype. ' <<
                "[FPS: #{Gosu.fps}. Tank @ #{@tank.x.round}:#{@tank.y.round}]"
            @caption_updated_at = now
        end
    end
end
