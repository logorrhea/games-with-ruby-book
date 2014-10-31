class BulletGraphics < Component
    COLOR = Gosu::Color::Black

    def draw(viewport)
        $window.draw_quad(@x - 2, @y - 2, COLOR,
                            @x + 2, @y - 2, COLOR,
                            @x - 2, @y + 2, COLOR,
                            @x + 2, @y + 2, COLOR,
                            1)
    end

end
