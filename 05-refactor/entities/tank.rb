class Tank < GameObject
    SHOOT_DELAY = 500
    attr_accessor :x, :y, :gun_angle, :direction, :sounds, :physics, :throttle_down

    def initialize(object_pool, input)
        super(object_pool)
        @input = input
        @input.control(self)
        @physics = TankPhysics.new(self, object_pool)
        @graphics = TankGraphics.new(self)
        @sounds = TankSounds.new(self)
        @direction = rand(0..7)* 45.0
        @gun_angle = rand(0..360)
        @last_shot = 0
    end

    def shoot(target_x, target_y)
        if Gosu.milliseconds - @last_shot > SHOOT_DELAY
            @last_shot = Gosu.milliseconds
            Bullet.new(object_pool, @x, @y, target_x, target_y).fire(100)
        end
    end

end

