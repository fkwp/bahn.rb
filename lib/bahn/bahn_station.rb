module Bahn
	class Station
		attr_accessor :lat, :lon, :name
		def initialize json={}		
			self.name = json["value"] unless json["value"].nil?
			
			if json[:do_load]
				station = Agent.new.find_station(name) if json[:load] == :station			
				station = Agent.new.find_address(name) if json[:load] == :foot
			end
			
			if station.nil?
				self.lat = json["ycoord"].insert(-7, ".") unless json["ycoord"].nil?
				self.lon = json["xcoord"].insert(-7, ".") unless json["xcoord"].nil?
			else
				self.lat = station.lat
				self.lon = station.lon
			end
		end
		
		def to_s
			"#{self.name} (#{self.lat},#{self.lon})"
		end
		
		def == other
			return false if other.nil?
			other.name == self.name
		end
	end
end