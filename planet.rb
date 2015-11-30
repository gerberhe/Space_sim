require "gosu"

class Planet

	def initialize(x, y, xvel, yvel, mass, name)
		@name = name
		@file = Gosu::Image.new("images/#{@name}")
		@x = x.to_f
		@y = y.to_f
		@xvel = xvel
		@yvel = yvel
		@mass = mass
		@scaledown = 1.92e-9
	end

	def draw
		@file.draw((@x * @scaledown) + 480, (@y * @scaledown) + 480, 1)
	end

end