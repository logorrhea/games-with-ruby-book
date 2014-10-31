class BulletSounds
    class << self
        
        def play
            sound.play
        end

        private

        def sound
            @@sound ||= Gosu::Sample.new(
                $window, Game.media_path('fire.mp3'))
        end

    end
end
