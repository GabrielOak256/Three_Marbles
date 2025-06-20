extends Node

const marble_diameter : int = 22 

const mouse_control    : bool = false
const highlight_player : bool = false
const quit_on_death    : bool = false
const vampiric_player  : bool = false

const primary_wall_avoidance : bool = false 
const secondary_wall_avoidance : bool = true 
const secondary_other_avoidance : bool = true 

const default_speed : int = 200 # was 400 instead of 200      # also defined in interpreter.gd
const marble_speed : Array[int] = [ 
	default_speed * 4, 
	default_speed, 
	default_speed, 
	default_speed, 
	default_speed, 
	default_speed, 
	default_speed, 
	default_speed * 2, 
	default_speed, 
	default_speed]  

const frozen_colors : Array[int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

# [this][considering] 0: ignore, 1: chase, 2: flee, 3: flock with
const behavior_table : Array = [
	[],                             # black - too simple for a behavior chart
	[],                             # white - too simple for a behavior chart
	[2, 2, 0, 2, 1, 2, 2, 2, 0, 0], # red
	[2, 2, 1, 0, 2, 2, 2, 2, 0, 0], # yellow
	[2, 2, 2, 1, 0, 2, 2, 2, 0, 0], # blue
	[2, 2, 0, 0, 0, 3, 1, 2, 0, 0], # orange 
	[2, 2, 0, 0, 0, 2, 3, 1, 0, 0], # green 
	[2, 2, 0, 0, 0, 1, 2, 3, 0, 0], # purple
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # gray
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], # brown
	#K  W  R  Y  B  O  G  P  A  N
	] 

# 0: [wins][wins], 1: [wins][loses], 2: [loses][wins], 3: [loses][loses]
const collision_table : Array = [
	[0],                           # black
	[3, 0],                        # white
	[2, 2, 0],                     # red
	[2, 2, 1, 0],                  # yellow
	[2, 2, 2, 1, 0],               # blue
	[2, 2, 1, 1, 1, 0],            # orange
	[2, 2, 1, 1, 1, 2, 0],         # green
	[2, 2, 1, 1, 1, 1, 2, 0],      # purple
	[0, 0, 0, 0, 0, 0, 0, 0, 0],   # gray
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # brown
	#K  W  R  Y  B  O  G  P  A  N
	]

const collision_commands : Array = [
	[""],                                    # black
	["", ""],                                # white
	["", "", ""],                            # red
	["", "", "", ""],                        # yellow
	["", "", "", "", ""],                    # blue
	["", "", "", "", "", ""],                # orange
	["", "", "", "", "", "", ""],            # green
	["", "", "", "", "", "", "", ""],        # purple
	["", "", "", "", "", "", "", "", ""],    # gray
	["", "", "", "", "", "", "", "", "", ""] # brown
	]

# How close do flockmates have to be before action is taken to meet their position?
const cohesion_range : Array[int] = [
	0,                            # black - too simple for flocking
	0,                            # white - too simple for flocking
	(marble_diameter * 6) ** 2,   # red
	(marble_diameter * 6) ** 2,   # yellow
	(marble_diameter * 6) ** 2,   # blue
	(marble_diameter * 100) ** 2, # orange 
	(marble_diameter * 6) ** 2,   # green
	(marble_diameter * 6) ** 2,   # purple
	(marble_diameter * 6) ** 2,   # gray
	(marble_diameter * 6) ** 2    # brown
	]

# How close do flockmates have to be before action is taken to match their direction?
const alignment_range : Array[int] = [
	0,                            # black - too simple for flocking
	0,                            # white - too simple for flocking
	(marble_diameter * 6) ** 2,   # red
	(marble_diameter * 6) ** 2,   # yellow
	(marble_diameter * 6) ** 2,   # blue
	(marble_diameter * 100) ** 2, # orange 
	(marble_diameter * 6) ** 2,   # green
	(marble_diameter * 6) ** 2,   # purple
	(marble_diameter * 6) ** 2,   # gray
	(marble_diameter * 6) ** 2    # brown
	]

# Spacing vs matching alignment?	       #K  W  R  Y  B  O  G  P  A  N
const alignment_weight : Array[float] = [0, 0, 1, 1, 1, 1, 1, 1, 1, 1]

# How close do flockmates have to be before action is taken to avoid them?
const separation_range : Array[int] = [
	0,                            # black - too simple for flocking
	0,                            # white - too simple for flocking
	(marble_diameter * 1.5) ** 2, # red
	(marble_diameter * 1.5) ** 2, # yellow
	(marble_diameter * 1.5) ** 2, # blue
	(marble_diameter * 6) ** 2,   # orange 
	(marble_diameter * 1.5) ** 2, # green
	(marble_diameter * 1.5) ** 2, # purple
	(marble_diameter * 1.5) ** 2, # gray
	(marble_diameter * 1.5) ** 2  # brown
	]

# How close do predator/prey marbles have to be to flee?
const flee_range : Array[int] = [
	0,                           # black - too simple for flocking
	0,                           # white - too simple for flocking
	(marble_diameter * 13) ** 2, # red
	(marble_diameter * 13) ** 2, # yellow
	(marble_diameter * 13) ** 2, # blue
	(marble_diameter * 13) ** 2, # orange 
	(marble_diameter * 13) ** 2, # green
	(marble_diameter * 13) ** 2, # purple
	(marble_diameter * 13) ** 2, # gray
	(marble_diameter * 13) ** 2  # brown
	]

# How close do predator/prey marbles have to be to engage?
const attack_range : Array[int] = [
	0,                          # black - too simple for flocking
	0,                          # white - too simple for flocking
	(marble_diameter * 3) ** 2, # red
	(marble_diameter * 3) ** 2, # yellow
	(marble_diameter * 3) ** 2, # blue
	(marble_diameter * 5) ** 2, # orange 
	(marble_diameter * 3) ** 2, # green
	(marble_diameter * 3) ** 2, # purple
	(marble_diameter * 3) ** 2, # gray
	(marble_diameter * 3) ** 2  # brown
	]
