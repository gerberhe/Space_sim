require "gosu"
require_relative 'planet'

class Window < Gosu::Window

	def initialize
		super(960,960)
		self.caption = "Gravity Sim"
		@background_image = Gosu::Image.new("images/starmap.jpg", :tileable => true)
		@info = File.new("simulations/planets.txt")
		@universal_info = @info.read.split("\n")
		@scaledown = 1.92e-9
		@distances_calculated = 0
	end

	def draw
		@background_image.draw(0, 0, 0, 2, 2)
		@num_planets = @universal_info[0]
		@planet_count = 1
		@planet_element_num = 2
		while @planet_count <= @num_planets.to_i
			@current_info = []
			@current_info.push(@universal_info[@planet_element_num].split(" "))
			@solar_body = Planet.new(@current_info[0][0], @current_info[0][1], @current_info[0][2], @current_info[0][3], @current_info[0][4], @current_info[0][5])
			@solar_body.draw
			@planet_count += 1
			@planet_element_num += 1
		end

		if @distances_calculated == 0
			calculate_distances
			@distances_calculated = 1
		end
	end

	def calculate_distances
		@planet_count2 = 1
		@distances = []
		@planet_num = 2
		@compare_next = 3
		while @planet_count2 <= @num_planets.to_i
			@current_planet = []
			@current_planet.push(@universal_info[@planet_num].split(" "))
			@current_planet_distances = []
			while @compare_next <= @num_planets.to_i + 1
				@distance = 0
				@next_planet = []
				@next_planet.push(@universal_info[@compare_next].split(" "))
				@triangle_x = (((@next_planet[0][0].to_f * @scaledown) + 480) - ((@current_planet[0][0].to_f * @scaledown) + 480))
				@triangle_y = (((@next_planet[0][1].to_f * @scaledown) + 480) - ((@current_planet[0][1].to_f * @scaledown) + 480))
				@distance = Math.sqrt((@triangle_x ** 2) + (@triangle_y ** 2))
				@current_planet_distances.push(@distance)
				@compare_next += 1
				puts @distance
			end
			@distances.push(@current_planet_distances)
			@planet_count2 += 1
			@compare_next = @planet_count2 + 1
			@planet_num += 1
		end
	end

end

window = Window.new
window.show