# This is the parent class from which all objects
# within the game inherit (such as tank, bullet, etc.)
#
# When GameObject is initialized, it registers itself with
# ObjectPool and prepares an empty array of @components.
#
# Update and draw simply cycle through @components and
# delegates those calls to each of them.
#   * Note that update should happen before draw
#

class GameObject

    def initialize(object_pool)
        @components = []
        @object_pool = object_pool
        @object_pool.objects << self
    end

    def components
        @components
    end

    def update
        @components.map(&:update)
    end

    def draw(viewport)
        @components.each { |c| c.draw(viewport) }
    end

    def removable?
        @removable
    end

    def mark_for_removal
        @removable = true
    end

    protected

    def object_pool
        @object_pool
    end

end
