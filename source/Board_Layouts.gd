extends Node

 # all of these squares make a circle all of these squares make a circle all of... 
# Explain to user that cohesion should be biggest, alignment when nearby, and separation when too close.

var selection : int = 0

const board_layouts : Array = [

# Tutorial
"$board 0

$place red random random
$delay 1 $place yellow 1 0
$delay 1 $place player blue 0 0
$delay 4
$delay 1 repeat $place red random random
$delay 1 repeat $place yellow random random
$delay 1 repeat $place blue random random

$score yellow == 0 max |Latest without Yellow: 
$score red >= 6 min |Earliest with 6 Red: ",


# Moon
"$board 1

$quit_on_death true

$place player blue -0.5 0
$place blue 0.5 0
$place red 0.5 -0.333333
$place red 0.6 0.333333
$place red 0.4 0.333333
$place red -0.5 0.333333
$place red -0.4 -0.333333
$place red -0.6 -0.333333
$place yellow 0.5 0.666666
$place yellow 0.6 -0.666666
$place yellow 0.4 -0.666666
$place yellow -0.5 -0.666666
$place yellow -0.4 0.666666
$place yellow -0.6 0.666666
$place red 0 0
$place polar red 1 0.835398
$place polar red 1 0.735398
$place polar red 1 2.40619
$place polar red 1 2.30619
$place polar red 1 3.97699
$place polar red 1 3.87699
$place polar red 1 5.54779
$place polar red 1 5.44779
$place red 0 1
$place red 0 -1
$place yellow 0.707107 0.707107
$place yellow 0.707107 -0.707107
$place yellow -0.707107 0.707107
$place yellow -0.707107 -0.707107

$score red == 0 min |Eliminate Red: 
$score yellow == 0 min |Eliminate Yellow: ",





# Whirlpool
"$board 2

$highlight_player true

$vampiric_player true

$place player blue 0 0.25
$place blue 0.0173719 0.237872
$place blue 0.0146035 0.210223
$place blue -0.0161931 0.188538
$place blue -0.0646138 0.195165
$place blue -0.105462 0.240031
$place blue -0.110617 0.312635
$place blue -0.0639871 0.383791
$place blue 0.0275656 0.417235
$place blue 0.133125 0.386513
$place blue 0.208112 0.289699
$place blue 0.212704 0.154764
$place blue 0.13079 0.0319847
$place blue -0.0190208 -0.0247662
$place blue -0.18618 0.0191002
$place blue -0.305178 0.161338
$place blue -0.32105 0.358794
$place blue -0.213529 0.540047
$place blue -0.00958351 0.631235
$place blue 0.222061 0.585752
$place blue 0.393973 0.405985
$place blue 0.432946 0.147496
$place blue 0.310429 -0.0976844
$place blue 0.0580346 -0.23382
$place yellow -0.239341 -0.198623
$place yellow -0.471931 0.00953893
$place yellow -0.545593 0.325901
$place yellow -0.419447 0.638956
$place yellow -0.125767 0.829735
$place yellow 0.236905 0.816896
$place yellow 0.536649 0.590568
$place yellow 0.656145 0.221123
$place yellow 0.538299 -0.162156
$place yellow 0.211868 -0.416278
$place yellow -0.213971 -0.437826
$place yellow -0.58592 -0.204486
$place red -0.761749 0.211678
$place red -0.664493 0.665867
$place red -0.315089 0.990865
$place red 0.859589 0.375094
$place red 0.795367 -0.148985
$place red 0.433861 -0.551072
$place red -0.105205 -0.676248
$place red -0.630488 -0.465148
$place red -0.946929 0.0195137
$place red -0.928122 0.61074
$place yellow 0.710301 -0.619675
$place yellow 0.086179 -0.890817
$place yellow -0.593163 -0.752983
$place yellow -1.07979 -0.241632
$place yellow -1.18764 0.468829

$score red == 0 min |Eliminate Red: ",



# Yinyang
"$board 3

$collision w k 3 $quit

$place black 0 -0.55
$place white 0 0.55
$place player blue 0.55 0
$place red 0 0
$place yellow -0.55 0

$score red == 0 min |Eliminate Red: ",



# Redeye
"$board 4

$quit_on_death true

$place player blue 0 0
$place yellow -0.05 0
$place yellow 0 0.05
$place yellow 0.05 0
$place polar red 0.111111 -2.0944
$place polar red 0.148148 -2.79253
$place polar red 0.185185 -3.49066
$place polar red 0.222222 -4.18879
$place polar red 0.259259 -4.88692
$place polar red 0.296296 -5.58505
$place polar red 0.333333 0
$place polar red 0.37037 0.698132
$place polar red 0.407407 1.39626
$place polar red 0.444444 2.0944
$place polar red 0.481481 2.79253
$place polar red 0.518519 3.49066
$place polar red 0.555556 4.18879
$place polar red 0.592593 4.88692
$place polar red 0.62963 5.58505
$place polar red 0.666667 -0
$place polar red 0.703704 -0.698132
$place polar red 0.740741 -1.39626
$place polar red 0.777778 -2.0944
$place polar red 0.814815 -2.79253
$place polar red 0.851852 -3.49066
$place polar red 0.888889 -4.18879
$place polar red 0.925926 -4.88692
$place polar red 0.962963 -5.58505

$score red == 0 min |Eliminate Red: 
$score yellow == 0 min |Eliminate Yellow: 
$score yellow == 0 max |Survive without Yellow: ",




# Creatures
"$board 5

$highlight_player true
$quit_on_death true

$alignment_weight green 2

$place player green 0 0
$place polar orange 0.75 -1.5708
$place polar orange 0.75 -1.39626
$place polar orange 0.75 -1.22173
$place polar orange 0.75 -1.0472
$place polar orange 0.75 -0.872665
$place polar orange 0.75 -0.698132
$place polar orange 0.75 -0.523599
$place polar orange 0.75 -0.349066
$place polar orange 0.75 -0.174533
$place polar orange 0.75 0
$place polar orange 0.75 0.174533
$place polar orange 0.75 0.349066
$place polar orange 0.75 0.523599
$place polar orange 0.75 0.698132
$place polar orange 0.75 0.872665
$place polar orange 0.75 1.0472
$place polar orange 0.75 1.22173
$place polar orange 0.75 1.39626
$place polar green 0.1 0
$place polar green 0.1 0.523599
$place polar green 0.1 1.0472
$place polar green 0.1 1.5708
$place polar green 0.1 2.0944
$place polar green 0.1 2.61799
$place polar green 0.1 3.14159
$place polar green 0.1 3.66519
$place polar green 0.1 4.18879
$place polar green 0.1 4.71239
$place polar green 0.1 5.23599
$place polar green 0.1 5.75959
$place polar green 0.2 0
$place polar green 0.2 0.523599
$place polar green 0.2 1.0472
$place polar green 0.2 1.5708
$place polar green 0.2 2.0944
$place polar green 0.2 2.61799
$place polar green 0.2 3.14159
$place polar green 0.2 3.66519
$place polar green 0.2 4.18879
$place polar green 0.2 4.71239
$place polar green 0.2 5.23599
$place polar green 0.2 5.75959
$place polar green 0.3 0
$place polar green 0.3 0.523599
$place polar green 0.3 1.0472
$place polar green 0.3 1.5708
$place polar green 0.3 2.0944
$place polar green 0.3 2.61799
$place polar green 0.3 3.14159
$place polar green 0.3 3.66519
$place polar green 0.3 4.18879
$place polar green 0.3 4.71239
$place polar green 0.3 5.23599
$place polar green 0.3 5.75959
$place purple -0.975 -0.1
$place purple -0.975 -0.1
$place purple -0.975 -0.1
$place purple -0.875 0
$place purple -0.875 0
$place purple -0.875 0
$place purple -0.775 0.1
$place purple -0.775 0.1
$place purple -0.775 0.1
$place purple -0.675 0.2
$place purple -0.675 0.2
$place purple -0.675 0.2

$score purple == 0 min |Eliminate Purple Scavengers: 
$score orange == 0 min |Eliminate Orange Pack: 
$score green == 1 max |Survive Alone: ",




# Shell
"$board 6

$alignment_weight orange 2

$behavior brown brown 3
$cohesion_range brown 100
$alignment_range brown 100
$alignment_weight brown 2
$separation_range brown 6
$flee_range brown 13
$attack_range brown 5

$behavior yellow white 0
$behavior yellow orange 0
$behavior yellow red 1
$behavior yellow brown 2
$behavior yellow black 2

$behavior orange white 3
$behavior orange yellow 3
$behavior orange red 2
$behavior orange brown 1
$behavior orange black 2

$behavior red white 2
$behavior red yellow 2
$behavior red orange 1
$behavior red brown 0
$behavior red black 0

$behavior brown white 2
$behavior brown yellow 1
$behavior brown orange 2
$behavior brown red 3
$behavior brown black 3

$collision white black 3 $quit

$collision white yellow 0
$collision white orange 0
$collision white red 1 orange
$collision white brown 1 yellow

$collision black yellow 1 brown
$collision black orange 1 red
$collision black red 0
$collision black brown 0

$collision yellow orange 0
$collision yellow red 1 orange
$collision orange brown 1 yellow
$collision red brown 0
$collision red orange 1 red
$collision brown yellow 1 brown

$place white 0 0
$place polar yellow 0.0277778 -2.26893
$place polar yellow 0.0555556 -2.96706
$place polar yellow 0.0833333 -3.66519
$place polar yellow 0.111111 -4.36332
$place polar yellow 0.138889 -5.06145
$place polar yellow 0.166667 -5.75959
$place polar yellow 0.194444 -6.45772
$place polar yellow 0.222222 -7.15585
$place polar yellow 0.25 -1.5708
$place polar orange 0.277778 -2.26893
$place polar orange 0.305556 -2.96706
$place polar orange 0.333333 -3.66519
$place polar orange 0.361111 -4.36332
$place polar orange 0.388889 -5.06145
$place polar orange 0.416667 -5.75959
$place polar orange 0.444444 -6.45772
$place polar orange 0.472222 -7.15585
$place polar orange 0.5 -1.5708
$place polar red 0.527778 -2.26893
$place polar red 0.555556 -2.96706
$place polar red 0.583333 -3.66519
$place polar red 0.611111 -4.36332
$place polar red 0.638889 -5.06145
$place polar red 0.666667 -5.75959
$place polar red 0.694444 -6.45772
$place polar red 0.722222 -7.15585
$place polar red 0.75 -1.5708
$place polar brown 0.777778 -2.26893
$place polar brown 0.805556 -2.96706
$place polar brown 0.833333 -3.66519
$place polar brown 0.861111 -4.36332
$place polar brown 0.888889 -5.06145
$place polar brown 0.916667 -5.75959
$place polar brown 0.944444 -6.45772
$place polar brown 0.972222 -7.15585
$place black 0 -1",


# Galaxy
"$board 7

$highlight_player true
$quit_on_death true

$freeze a true

$collision r a 2
$collision y a 2
$collision b a 2
$behavior r a 2
$behavior y a 2
$behavior b a 2

$place player blue 0 0

$place polar blue 0.25 0
$place polar yellow 0.25 0.523599
$place polar red 0.25 1.0472
$place polar blue 0.25 1.5708
$place polar yellow 0.25 2.0944
$place polar red 0.25 2.61799
$place polar blue 0.25 3.14159
$place polar yellow 0.25 3.66519
$place polar red 0.25 4.18879
$place polar blue 0.25 4.71239
$place polar yellow 0.25 5.23599
$place polar red 0.25 5.75959
$place polar red 0.75 0
$place polar yellow 0.75 0.349066
$place polar blue 0.75 0.698132
$place polar red 0.75 1.0472
$place polar yellow 0.75 1.39626
$place polar blue 0.75 1.74533
$place polar red 0.75 2.0944
$place polar yellow 0.75 2.44346
$place polar blue 0.75 2.79253
$place polar red 0.75 3.14159
$place polar yellow 0.75 3.49066
$place polar blue 0.75 3.83972
$place polar red 0.75 4.18879
$place polar yellow 0.75 4.53786
$place polar blue 0.75 4.88692
$place polar red 0.75 5.23599
$place polar yellow 0.75 5.58505
$place polar blue 0.75 5.93412
$place polar gray 1 0
$place polar gray 1 0.349066
$place polar gray 1 0.698132
$place polar gray 1 1.0472
$place polar gray 1 1.39626
$place polar gray 1 1.74533
$place polar gray 1 2.0944
$place polar gray 1 2.44346
$place polar gray 1 2.79253
$place polar gray 1 3.14159
$place polar gray 1 3.49066
$place polar gray 1 3.83972
$place polar gray 1 4.18879
$place polar gray 1 4.53786
$place polar gray 1 4.88692
$place polar gray 1 5.23599
$place polar gray 1 5.58505
$place polar gray 1 5.93412

$score red == 0 min |Eliminate Red: ",



# Metatron
"$board 8

$freeze a true

$highlight_player true
$quit_on_death true

$alignment_weight orange 2

$alignment_weight green 2

$alignment_weight purple 2

$collision r a 2
$collision o a 2
$collision y a 2
$collision g a 2
$collision b a 2
$collision p a 2
$behavior r a 2
$behavior o a 2
$behavior y a 2
$behavior g a 2
$behavior b a 2
$behavior p a 2

$collision red purple 0
$behavior red purple 0
$behavior purple red 3
$collision red blue 1 purple

$collision yellow orange 0
$behavior yellow orange 0
$behavior orange yellow 3
$collision yellow red 1 orange

$collision blue green 0
$behavior blue green 0
$behavior green blue 3
$collision blue yellow 1 green

$place polar red 0.25 0.261799
$place polar red 0.25 0.785398
$place polar red 0.25 1.309
$place polar red 0.25 1.8326
$place polar yellow 0.25 2.35619
$place polar yellow 0.25 2.87979
$place polar yellow 0.25 3.40339
$place polar yellow 0.25 3.92699
$place polar blue 0.25 4.45059
$place polar blue 0.25 4.97419
$place polar blue 0.25 5.49779
$place polar blue 0.25 6.02139
$place polar gray 0.45 0.523599
$place polar gray 0.45 1.5708
$place polar gray 0.45 2.61799
$place polar gray 0.45 3.66519
$place polar gray 0.45 4.71239
$place polar gray 0.45 5.75959
$place polar red 0.666666 0.261799
$place polar red 0.666666 0.785398
$place polar red 0.666666 1.309
$place polar red 0.666666 1.8326
$place polar yellow 0.666666 2.35619
$place polar yellow 0.666666 2.87979
$place polar yellow 0.666666 3.40339
$place polar yellow 0.666666 3.92699
$place polar blue 0.666666 4.45059
$place polar blue 0.666666 4.97419
$place polar blue 0.666666 5.49779
$place player polar blue 0.666666 6.02139
$place polar gray 0.875 0.523599
$place polar gray 0.875 1.5708
$place polar gray 0.875 2.61799
$place polar gray 0.875 3.66519
$place polar gray 0.875 4.71239
$place polar gray 0.875 5.75959
$place polar purple 1 0.261799
$place polar red 1 0.785398
$place polar red 1 1.309
$place polar red 1 1.8326
$place polar orange 1 2.35619
$place polar yellow 1 2.87979
$place polar yellow 1 3.40339
$place polar yellow 1 3.92699
$place polar green 1 4.45059
$place polar blue 1 4.97419
$place polar blue 1 5.49779
$place polar blue 1 6.02139

$score red == 0 min |Eliminate Red: 
$score orange == 0 min |Eliminate Orange: 
$score purple == 0 min |Eliminate Purple: ",



# Engine
"$board 9

$behavior r a 2
$collision r a 2

$place player blue 0 0
$place polar gray 0.05 0.523599
$place polar gray 0.05 1.5708
$place polar gray 0.05 2.61799
$place polar gray 0.05 3.66519
$place polar gray 0.05 4.71239
$place polar gray 0.05 5.75959
$place polar red 0.6 0.523599
$place polar red 0.1 1.5708
$place polar red 0.8 2.61799
$place polar red 0.3 3.66519
$place polar red 0.9 4.71239
$place polar red 0.1 5.75959
$place polar gray 1 0.523599
$place polar gray 1 1.5708
$place polar gray 1 2.61799
$place polar gray 1 3.66519
$place polar gray 1 4.71239
$place polar gray 1 5.75959

$score red == 0 min |Eliminate Red: ",





# Nebula
"$board 10

$collision k n 1
$collision w k 1

$place white 1 0

$place black -0.606092 -0.606092
$place black -0.606092 -0.404061
$place black -0.606092 -0.202031
$place black -0.606092 0
$place black -0.606092 0.202031
$place black -0.606092 0.404061
$place black -0.606092 0.606092
$place black -0.404061 -0.606092
$place black -0.404061 -0.404061
$place black -0.404061 -0.202031
$place black -0.404061 0
$place black -0.404061 0.202031
$place black -0.404061 0.404061
$place black -0.404061 0.606092
$place black -0.202031 -0.606092
$place black -0.202031 -0.404061
$place black -0.202031 -0.202031
$place black -0.202031 0
$place black -0.202031 0.202031
$place black -0.202031 0.404061
$place black -0.202031 0.606092
$place black 0 -0.606092
$place black 0 -0.404061
$place black 0 -0.202031
$place player brown 0 0
$place black 0 0.202031
$place black 0 0.404061
$place black 0 0.606092
$place black 0.202031 -0.606092
$place black 0.202031 -0.404061
$place black 0.202031 -0.202031
$place black 0.202031 0
$place black 0.202031 0.202031
$place black 0.202031 0.404061
$place black 0.202031 0.606092
$place black 0.404061 -0.606092
$place black 0.404061 -0.404061
$place black 0.404061 -0.202031
$place black 0.404061 0
$place black 0.404061 0.202031
$place black 0.404061 0.404061
$place black 0.404061 0.606092
$place black 0.606092 -0.606092
$place black 0.606092 -0.404061
$place black 0.606092 -0.202031
$place black 0.606092 0
$place black 0.606092 0.202031
$place black 0.606092 0.404061
$place black 0.606092 0.606092

$score black <= 42 min |Survive to 6 Black Eliminated: 
$score black <= 36 min |Survive to one quarter Black Eliminated: 
$score black <= 24 min |Survive to half of the Black Eliminated: 
$score black <= 12 min |Survive to three quarters of the Black Eliminated: 
$score black == 0 min |Survive to All Black Eliminated: ",




# Pandemonium
"$board 11

$quit_on_death true

$place player blue 0 0
$place black -0.0625 0.0609375
$place black -0.0625 -0.0609375
$place black 0 0.1
$place black 0 -0.1
$place black 0.0625 0.0609375
$place black 0.0625 -0.0609375
$place red -0.75 0.052083
$place red -0.75 -0.052083
$place red -0.5 0.208333
$place red -0.5 -0.208333
$place red -0.25 0.302083
$place red -0.25 -0.302083
$place red 0 0.333333
$place red 0 -0.333333
$place red 0.25 0.302083
$place red 0.25 -0.302083
$place red 0.5 0.208333
$place red 0.5 -0.208333
$place red 0.75 0.052083
$place red 0.75 -0.052083"]



const default_custom_board_layout : String = "$board 0

$label 0 0 0 |Custom\\nLevel

$delay 10 $quit

$collision k k 0

$collision w k 0
$collision w w 0

$collision r k 0
$collision r w 0
$collision r r 0

$collision y k 0
$collision y w 0
$collision y r 0
$collision y y 0

$collision b w 0
$collision b k 0
$collision b r 0
$collision b y 0
$collision b b 0

$collision o k 0
$collision o w 0
$collision o r 0
$collision o y 0
$collision o b 0
$collision o o 0

$collision g k 0
$collision g w 0
$collision g r 0
$collision g y 0
$collision g b 0
$collision g o 0
$collision g g 0

$collision p k 0
$collision p w 0
$collision p r 0
$collision p y 0
$collision p b 0
$collision p o 0
$collision p g 0
$collision p p 0

$collision a k 0
$collision a w 0
$collision a r 0
$collision a y 0
$collision a b 0
$collision a o 0
$collision a g 0
$collision a p 0
$collision a a 0

$collision n k 0
$collision n w 0
$collision n r 0
$collision n y 0
$collision n b 0
$collision n o 0
$collision n g 0
$collision n p 0
$collision n a 0
$collision n n 0

$place player black 0 0
$place polar black 0.0773823 10.1664
$place polar black 0.109435 20.3328
$place polar black 0.13403 30.4992
$place polar black 0.154765 40.6656
$place polar black 0.173032 50.832
$place polar black 0.189547 60.9984
$place polar black 0.204734 71.1649
$place polar black 0.21887 81.3313
$place polar black 0.232147 91.4977
$place polar black 0.244704 101.664
$place polar black 0.256648 111.83
$place polar black 0.26806 121.997
$place polar black 0.279006 132.163
$place polar black 0.289538 142.33
$place polar black 0.2997 152.496
$place polar black 0.309529 162.663
$place polar black 0.319055 172.829
$place polar black 0.328305 182.995
$place polar black 0.337302 193.162
$place polar black 0.346064 203.328
$place polar purple 0.35461 213.495
$place polar orange 0.362955 223.661
$place polar green 0.371113 233.827
$place polar red 0.379094 243.994
$place polar yellow 0.386912 254.16
$place polar blue 0.394574 264.327
$place polar red 0.40209 274.493
$place polar green 0.409469 284.659
$place polar purple 0.416717 294.826
$place polar orange 0.42384 304.992
$place polar green 0.430847 315.159
$place polar red 0.437741 325.325
$place polar yellow 0.444528 335.491
$place polar blue 0.451213 345.658
$place polar red 0.4578 355.824
$place polar green 0.464294 365.991
$place polar purple 0.470698 376.157
$place polar orange 0.477017 386.323
$place polar green 0.483252 396.49
$place polar red 0.489409 406.656
$place polar yellow 0.495489 416.823
$place polar blue 0.501495 426.989
$place polar red 0.50743 437.156
$place polar green 0.513296 447.322
$place polar purple 0.519096 457.488
$place polar orange 0.524832 467.655
$place polar green 0.530506 477.821
$place polar red 0.53612 487.988
$place polar yellow 0.541676 498.154
$place polar blue 0.547176 508.32
$place polar red 0.55262 518.487
$place polar green 0.558012 528.653
$place polar purple 0.563352 538.82
$place polar orange 0.568642 548.986
$place polar green 0.573883 559.152
$place polar red 0.579076 569.319
$place polar yellow 0.584224 579.485
$place polar blue 0.589326 589.652
$place polar red 0.594385 599.818
$place polar green 0.599401 609.984
$place polar purple 0.604375 620.151
$place polar orange 0.609309 630.317
$place polar gray 0.614203 640.484
$place polar gray 0.619059 650.65
$place polar gray 0.623876 660.816
$place polar gray 0.628657 670.983
$place polar gray 0.633402 681.149
$place polar gray 0.638111 691.316
$place polar gray 0.642786 701.482
$place polar gray 0.647427 711.649
$place polar gray 0.652035 721.815
$place polar gray 0.656611 731.981
$place polar gray 0.661155 742.148
$place polar gray 0.665668 752.314
$place polar gray 0.670151 762.481
$place polar gray 0.674603 772.647
$place polar gray 0.679027 782.813
$place polar gray 0.683422 792.98
$place polar gray 0.687789 803.146
$place polar gray 0.692129 813.313
$place polar gray 0.696441 823.479
$place polar gray 0.700727 833.645
$place polar gray 0.704987 843.812
$place polar green 0.709221 853.978
$place polar purple 0.71343 864.145
$place polar orange 0.717614 874.311
$place polar green 0.721774 884.477
$place polar red 0.725911 894.644
$place polar yellow 0.730023 904.81
$place polar blue 0.734113 914.977
$place polar red 0.73818 925.143
$place polar green 0.742225 935.309
$place polar purple 0.746248 945.476
$place polar orange 0.750249 955.642
$place polar green 0.75423 965.809
$place polar red 0.758189 975.975
$place polar yellow 0.762127 986.142
$place polar blue 0.766046 996.308
$place polar red 0.769944 1006.47
$place polar green 0.773823 1016.64
$place polar purple 0.777683 1026.81
$place polar orange 0.781523 1036.97
$place polar green 0.785345 1047.14
$place polar red 0.789148 1057.31
$place polar yellow 0.792933 1067.47
$place polar blue 0.7967 1077.64
$place polar red 0.800449 1087.81
$place polar green 0.804181 1097.97
$place polar purple 0.807895 1108.14
$place polar orange 0.811593 1118.3
$place polar green 0.815273 1128.47
$place polar red 0.818938 1138.64
$place polar yellow 0.822585 1148.8
$place polar blue 0.826217 1158.97
$place polar red 0.829833 1169.14
$place polar green 0.833433 1179.3
$place polar purple 0.837018 1189.47
$place polar orange 0.840587 1199.64
$place polar green 0.844141 1209.8
$place polar red 0.847681 1219.97
$place polar yellow 0.851206 1230.14
$place polar blue 0.854716 1240.3
$place polar red 0.858211 1250.47
$place polar green 0.861693 1260.63
$place polar purple 0.865161 1270.8
$place polar orange 0.868614 1280.97
$place polar green 0.872054 1291.13
$place polar red 0.875481 1301.3
$place polar yellow 0.878894 1311.47
$place polar blue 0.882294 1321.63
$place polar red 0.885681 1331.8
$place polar green 0.889055 1341.97
$place polar purple 0.892416 1352.13
$place polar orange 0.895765 1362.3
$place polar green 0.899101 1372.46
$place polar red 0.902425 1382.63
$place polar yellow 0.905737 1392.8
$place polar blue 0.909036 1402.96
$place polar red 0.912324 1413.13
$place polar green 0.9156 1423.3
$place polar purple 0.918864 1433.46
$place polar orange 0.922117 1443.63
$place polar green 0.925358 1453.8
$place polar red 0.928588 1463.96
$place polar yellow 0.931807 1474.13
$place polar blue 0.935014 1484.3
$place polar white 0.938211 1494.46
$place polar white 0.941397 1504.63
$place polar white 0.944572 1514.79
$place polar white 0.947736 1524.96
$place polar white 0.95089 1535.13
$place polar white 0.954033 1545.29
$place polar white 0.957166 1555.46
$place polar white 0.960289 1565.63
$place polar white 0.963402 1575.79
$place polar white 0.966505 1585.96
$place polar white 0.969598 1596.13
$place polar white 0.972681 1606.29
$place polar white 0.975754 1616.46
$place polar white 0.978818 1626.63
$place polar white 0.981872 1636.79
$place polar white 0.984916 1646.96
$place polar white 0.987951 1657.12
$place polar white 0.990977 1667.29
$place polar white 0.993994 1677.46
$place polar white 0.997001 1687.62
$place polar white 1 1697.79"







const menu_text : Array[Array] = [

# Tutorial
["Welcome to Three Marbles. Red takes Blue, Blue takes Yellow, Yellow takes Red. 

Proceed to the Game Board by pressing Ctrl + S.
Use Arrow Keys or WASD to move. You start as Blue.
Pause the game with Spacebar.
Exit to Main Menu by pressing Q. 
From the Main Menu, the Game Board of each level can be played by Left-Clicking, and the Settings Menu reviewed by Right-Clicking. 
From the Main Menu, to reset your high scores and Custom Level, press Shift + Ctrl + Alt + Backspace.





Each time you start a level, the corresponding Settings Menu text is processed, and sets up the board.
********************************************************************************
	Custom Level Manual:

A command starts with ‘$’, and is written at the very beginning of the line, followed by its arguments. 
A [bool] argument can be any of: \"true\", \"1\", \"false\", or \"0\".
An [int] argument can be any whole number.
A [float] argument can be any decimal, for example -0.05, 1, 1.0, or 0.333333.
A [color] argument can be any of: \"black\", \"k\", \"white\", \"w\", \"red\", \"r\", \"yellow\", \"y\", \"blue\", \"b\", \"orange\", \"o\", \"green\", \"g\", \"purple\", \"p\", \"gray\", \"a\", \"brown\", or \"n\".

\"$board [int]\"
0. Wooden Game Board
1. The far side of the Moon
2. Whirlpool
3. Yin Yang
4. The Red Eye of Jupiter
5. Garden
6. Sea Shell
7. Galaxy
8. The Platonic Solids (Metatron’s Cube)
9. Radial Piston Engine
10. Nebula
11. Pandemonium
12. All of these squares make a circle, all of these squares make a circle, all of these squares make a circle,  all of these squares make a circle, all of these squares make a circle, all of these squares make a circle, all of these squares make a circle, all 


\"$mouse_control [bool]\"
If enabled, the player marble with constantly move towards the player’s cursor. Default \"false\".
This depends on user preference. I find it more difficult to preform precise movement, but if you prefer it, then simply copy-paste each level’s Settings into Custom Level, with the addition of \"$mouse_control true\".
If you make a Custom Level with this enabled, tell your users to pause the game while they center their cursor.

\"$highlight_player [bool]\"
If enabled, the player marble is highlighted. Default \"false\".
Intended for when it is unclear which marble is the player’s at the start.

\"$quit_on_death [bool]\"
If enabled, quit when the player dies. Default \"false\".
If you want to see what becomes of the board after the player dies, copy-paste the level’s Settings into Custom Level, and delete this command.

\"$vampiric_player [bool]\"
If enabled, the player marble will take on the color of marbles it takes. Default \"false\".


\"$primary_wall_avoidance [bool]\"
Will marbles that aren’t capable of flocking attempt to avoid colliding with the walls? Default “false”.
This causes a lot more movement among non-flocking marbles, which makes for more energetic gameplay, but disturbs the peaceful movement they have without it. 

\"$secondary_wall_avoidance [bool]\"
Will marbles that are capable of flocking attempt to avoid colliding with the walls? Default “true”.

\"$secondary_other_avoidance [bool]\"
Will marbles that are capable of flocking attempt to avoid colliding with marbles that are otherwise ignored? Default “true”.
Disabling this may, or may not, speed the game up in a densely packed Custom Level.


\"$cohesion_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to try to fall in? 
If no marbles are in range, it will simply go to the nearest individual of a color it flocks with. 
The range is the diameter of a marble times the specified float.

\"$alignment_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to try to match heading?
If no marbles are in range, it will simply go to the nearest individual of a color it flocks with. 
The range is the diameter of a marble times the specified float.

\"$alignment_weight [color] [float]\"
How important is matching heading versus maintaining spacing? Without any concern for spacing, 
they would exactly match the movements of their neighbors in perfect formation.
1 is the default and places equal importance on heading and spacing. 2 gives the player a bit of control among their flockmates.

\"$separation_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to be avoided? 
The range is the diameter of a marble times the specified float.

\"$flee_range [color] [float]\"
How close does a threat have to be to begin moving away? Measured in the marble diameter.

\"$attack_range [color] [float]\"
How close does a target have to be to begin moving in? Measured in the marble diameter.


\"$freeze [color] [bool]\"
Used to freeze or unfreeze marbles of the specified color during placement. To freeze all marbles of the selected color, put the command before all $place commands. Not compatible with $delay.

\"$speed [color] [float]\"
Used to set the speed of the color to the default speed times the default amount. 
Consider the example: \"$collision blue yellow 1 $speed blue 4\", which quadruples the speed of Blue the first time one hits a Yellow. 
If you don’t like the default speed, change the speed of each color to your preferred value in the Custom Level.

\"$behavior [color] [color] [int]\"
Defines how the first color sees the second.
0. Ignores
1. Attacks
2. Flees
3. Flocks with
If a marble doesn’t flock with any color, then it attacks or flees the nearest relevant marble. The behavior of Black and White marbles 
cannot be changed. Although Gray and Brown marbles aren’t set to do anything by default, and are ready to be customized. 

\"$collision [color] [color] [int] ([color] [color] ...) ($...)\"
Defines what happens when marbles of the specified colors collide. 
0. Nothing happens.
1. The first color wins, the second is taken.
2. The second color wins, the first is taken.
3. Both are taken.
You can add optional colors after the int argument to place new marbles, and run a life simulation. 
And/or an optional command to be ran on collision, for example \"$collision k w 3 $quit\". Doesn’t support $delay commands being added for a collision.


\"$place (player) (polar) [color] [float] [float]\"
This command places a marble of the specified color at the specified coordinates. 
Include the \"polar\" flag to use (radius, angle) instead of (x, y) coordinates, which saves you from calculating (radius*cos(angle), radius*sin(angle)). 
The length of the radius is 1.0, so one eighth left and three eighths down would be would be (-0.125, -0.375).
Include the \"player\" flag to place a player marble. 

\"$delay [int] (repeat) ($...)\"
Specify an int amount of seconds to delay execution of a command. The delays stack up; 
they don’t all start counting up at the start of the level. 
Include an optional “repeat” flag to keep running the command after the specified delay after all single-firing delayed commands finish.
Without including a command, this simply adds the specified delay to the clock before getting to the next $delay command.


\"$score [color] [comparator] [int] [“min” or “max”] | ...\"
Tells the Game Board which conditions to keep track of. If the comparison between the specified amount of the specified color and the current amount of that color is true, then if the current time is better we save it.
The comparator can be any of \"==\", \"!=\", \"<\", \">\", \"<=\", \">=\". 
Respectively meaning equals, doesn’t equal, less than, greater than, less than or equal, greater than or equal. 
\"min\" means that a shorter time is better, \"max\" means a longer time is better.
Everything to the right of the \"|\" pipe is the text label that explains the scoring condition to the user.
Type \"\\n\" for a newline. 


\"$label [int] [int] [int] | ...\"
Used to change the name of the Custom Level in the Main Menu. So when you text a Custom Level to your friends, 
their Main Menu will display your title. The first three arguments make a Red Green Blue code, and each can be 0 to 255. 
Then everything to the right of the \"|\" pipe is the text label. Type \"\\n\" for a newline. 


\"$quit\"
When this command is executed, the Game Board will return to the Main Menu. 
It will be ignored if ran by itself, and is intended to be used after $delay or $collision.

********************************************************************************
And here are the instructions used to set up the Tutorial:\n\n", # Tutorial



"The default values for what can be changed in the Custom Level.

mouse_control = false
highlight_player = false
quit_on_death = false
vampiric_player = false

primary_wall_avoidance = false 
secondary_wall_avoidance = true 
secondary_other_avoidance = true 

marble_speed, by default is [4, 1, 1, 1, 1, 1, 1, 2, 1, 1] #K  W  R  Y  B  O  G  P  A  N

frozen_colors, by default is false for all colors.

# [this][considering] 0: ignore, 1: chase, 2: flee, 3: flock with
behavior_table
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

# 0: [wins][wins], 1: [wins][loses], 2: [loses][wins], 3: [loses][loses]
collision_table
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

collision_commands, by default is totally empty.

cohesion_range         
0,                     # black - too simple for flocking
0,                     # white - too simple for flocking
marble_diameter * 6,   # red
marble_diameter * 6,   # yellow
marble_diameter * 6,   # blue
marble_diameter * 100, # orange 
marble_diameter * 6,   # green
marble_diameter * 6,   # purple
marble_diameter * 6,   # gray
marble_diameter * 6    # brown

alignment_range, by default is identical to cohesion_range.

alignment_weight, by default is 1 for all colors (except Black and White).

separation_range 
0,                      # black - too simple for flocking
0,                      # white - too simple for flocking
marble_diameter * 1.5   # red
marble_diameter * 1.5   # yellow
marble_diameter * 1.5   # blue
marble_diameter * 6     # orange 
marble_diameter * 1.5   # green
marble_diameter * 1.5   # purple
marble_diameter * 1.5   # gray
marble_diameter * 1.5   # brown

flee_range, by default is 13 diameters for all colors (except Black and White).

attack_range, by default is [0, 0, 3, 3, 3, 5, 3, 3, 3, 3] #K  W  R  Y  B  O  G  P  A  N\n\n", # British


"???", # Mandarin

# Poorly Translated
"Welcome to Three Marbles. Red takes Blue, Blue takes Yellow, Yellow takes Red. 

Proceed to the Game Board by pressing Ctrl + S.
Use Arrow Keys or WASD to move. You start as Blue.
Pause the game with Spacebar.
Exit to Main Menu by pressing Q. 
From the Main Menu, the Game Board of each level can be played by Left-Clicking, and the Settings Menu reviewed by Right-Clicking. 
From the Main Menu, to reset your high scores and Custom Level, press Shift + Ctrl + Alt + Backspace.
Than Q for playing.



Levels are set up automatically by Lightning Brain, and should not be helped by Manuel. 
********************************************************************************
	Custom Level Manual:
Anyone obeying level layout regulations may be required to leave.

A command starts with ‘$’, and is written at the very beginning of the line, followed by its arguments. 
A [bool] argument can be any of: \"true\", \"1\", \"false\", or \"0\".
An [int] argument can be any whole number.
A [float] argument can be any decimal, for example -0.05, 1, 1.0, or 0.333333.
A [color] argument can be any of: \"black\", \"k\", \"white\", \"w\", \"red\", \"r\", \"yellow\", \"y\", \"blue\", \"b\", \"orange\", \"o\", \"green\", \"g\", \"purple\", \"p\", \"gray\", \"a\", \"brown\", or \"n\".

\"$board [int]\"
0. Wooden Game Board
1. The far side of the Moon
2. Whirlpool
3. Yin Yang
4. The Red Eye of Jupiter
5. Garden
6. Sea Shell
7. Galaxy
8. The Platonic Solids (Metat... Mete... Mettaer... Nevermind)
9. Radial Piston Engine
10. Nebula
11. Pandemonium
12. All of these squares make a circle, all of these squares make a circle, all of these squares make a circle,  all of these squares make a circle, all of these squares make a circle, all of these squares make a circle, all of these squares make a circle, all 


\"$mouse_control [bool]\"
The mouse can be difficult to control, but can be released from its wheel with: \"$mouse_control true\".

\"$highlight_player [bool]\"
If enabled, the player marble is highlighted. Default \"false\".
Intended for when it is unclear which marble is the player’s at the start.

\"$quit_on_death [bool]\"
If enabled, quit when the player dies. Default \"false\".
If you want to see what becomes of the board after the player dies, copy-paste the level’s Settings into Custom Level, and delete this command.

\"$vampiric_player [bool]\"
If enabled, the player marble will take on the color of marbles it takes. Default \"false\".


\"$primary_wall_avoidance [bool]\"
Will marbles that aren’t capable of flocking attempt to avoid colliding with the walls? Default “false”.
This causes a lot more movement among non-flocking marbles, which makes for more energetic gameplay, but disturbs the peaceful movement they have without it. 

\"$secondary_wall_avoidance [bool]\"
Will marbles that are capable of flocking attempt to avoid colliding with the walls? Default “true”.

\"$secondary_other_avoidance [bool]\"
Will marbles that are capable of flocking attempt to avoid colliding with marbles that are otherwise ignored? Default “true”.
Disabling this may, or may not, speed the game up in a densely packed Custom Level.


\"$cohesion_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to try to fall in? 
If no marbles are in range, it will simply go to the nearest individual of a color it flocks with. 
The range is the diameter of a marble times the specified float.

\"$alignment_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to try to match heading?
If no marbles are in range, it will simply go to the nearest individual of a color it flocks with. 
The range is the diameter of a marble times the specified float.

\"$alignment_weight [color] [float]\"
How important is matching heading versus maintaining spacing? Without any concern for spacing, 
they would exactly match the movements of their neighbors in perfect formation.
1 is the default and places equal importance on heading and spacing. 2 gives the player a bit of control among their flockmates.

\"$separation_range [color] [float]\"
How close do marbles of colors that the specified color flocks with have to be to be avoided? 
The range is the diameter of a marble times the specified float.

Cohesion range should be the longest, followed by Alignment which can be equal to Cohesion, then Seperation range smallest. 

\"$flee_range [color] [float]\"
How close does a threat have to be to begin moving away? Measured in the marble diameter.

\"$attack_range [color] [float]\"
How close does a target have to be to begin moving in? Measured in the marble diameter.


\"$freeze [color] [bool]\"
Used to freeze or unfreeze marbles of the specified color during placement. To freeze all marbles of the selected color, put the command before all $place commands. Not compatible with $delay.

\"$speed [color] [float]\"
Used to set the speed of the color to the default speed times the default amount. 
Consider the example: \"$collision blue yellow 1 $speed blue 4\", which quadruples the speed of Blue the first time one hits a Yellow. 
If you don’t like the default speed, change the speed of each color to your preferred value in the Custom Level.

\"$behavior [color] [color] [int]\"
Defines how the first color sees the second.
0. Ignores
1. Attacks
2. Flees
3. Flocks with
If a marble doesn’t flock with any color, then it attacks or flees the nearest relevant marble. The behavior of Black and White marbles 
cannot be changed. Although Gray and Brown marbles aren’t set to do anything by default, and are ready to be customized. 

\"$collision [color] [color] [int] ([color] [color] ...) ($...)\"
Defines what happens when marbles of the specified colors collide. 
0. Nothing happens.
1. The first color wins, the second is taken.
2. The second color wins, the first is taken.
3. Both are taken.
You can add optional colors after the int argument to place new marbles, and run a life simulation. 
And/or an optional command to be ran on collision, for example \"$collision k w 3 $quit\". Doesn’t support $delay commands being added for a collision.


\"$place (player) (polar) [color] [float] [float]\"
This command places a marble of the specified color at the specified coordinates. 
Include the \"polar\" flag to use (radius, angle) instead of (x, y) coordinates, which saves you from calculating (radius*cos(angle), radius*sin(angle)). 
The length of the radius is 1.0, so one eighth left and three eighths down would be would be (-0.125, -0.375).
Include the \"player\" flag to place a player marble. 

\"$delay [int] (repeat) ($...)\"
Specify an int amount of seconds to delay execution of a command. The delays stack up; 
they don’t all start counting up at the start of the level. 
Include an optional “repeat” flag to keep running the command after the specified delay after all single-firing delayed commands finish.
Without including a command, this simply adds the specified delay to the clock before getting to the next $delay command.


\"$score [color] [comparator] [int] [“min” or “max”] | ...\"
Tells the Game Board which conditions to keep track of. If the comparison between the specified amount of the specified color and the current amount of that color is true, then if the current time is better we save it.
The comparator can be any of \"==\", \"!=\", \"<\", \">\", \"<=\", \">=\". 
Respectively meaning equals, doesn’t equal, less than, greater than, less than or equal, greater than or equal. 
\"min\" means that a shorter time is better, \"max\" means a longer time is better.
Everything to the right of the \"|\" pipe is the text label that explains the scoring condition to the user.
Type \"\\n\" for a newline. 


\"$label [int] [int] [int] | ...\"
Used to change the name of the Custom Level in the Main Menu. So when you text a Custom Level to your friends, 
their Main Menu will display your title. The first three arguments make a Red Green Blue code, and each can be 0 to 255. 
Then everything to the right of the \"|\" pipe is the text label. Type \"\\n\" for a newline. 


\"$quit\"
When this command is executed, the Game Board will return to the Main Menu. 
It will be ignored if ran by itself, and is intended to be used after $delay or $collision.

********************************************************************************
And here are the instructions used to set up the Tutorial:\n\n"], # Tutorial 


["This game was made using Godot, Blender, and Krita. 
Code fragments made freely available by Sebastian Lauge, NAD LABS, and Suboptimal Engineer 
were invaluable in getting the BOID behavior working.

The Godot License:

  Copyright (c) 2014-present Godot Engine contributors.
  Copyright (c) 2007-2014 Juan Linietsky, Ariel Manzur.

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the \"Software\"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  -- Godot Engine <https://godotengine.org>\n\n", "The Moon Landing is further evidence that Americans like cheese.\n\n", "", "For proper service, turn on the toaster when using the rover.\n\n"], # Moon

["If this is too difficult, copy the below instructions into the Custom Level and delete some of the $place blue... commands.\n\n", # Whirlpool
"", # Whirlpool
"???", # Whirlpool
"Ouroboric Silver Wash\nHigh performance, fast acting products for innocent tableware.\n\n"], # Whirlpool

[ # Yin Yang
"Black and White marbles move without regard for other marbles.\n\n", 
"The contrast between the orderly and chaotic movements of these marbles are a perfect analogy for lands civilized by the Monarchy and the others.\n\n", 
"???\n\n", 
"Due to circumstance beyond our control, they move so much.\n\n"], 

["", "Why are you buying muskets at the tea store?!\n\n", "", ""], # Red Eye

# Creatures
["While primary colored marbles focus only on the nearest predator or prey, 
secondary colored marbles flock together, and derive strength from their numbers within flocking range.\n\n", # Creatures
"Have a right jolly time fearlessly moving your tight ranks into loose enemy formations.\n\n", # Creatures
"???", # Creatures
""], # Creatures

# Shell
["If you want to add a player to this level, simply paste the below into the Custom Level, and add one.\n\n", # Shell
"", # Shell
"???", # Shell
""], # Shell

# Galaxy
["Hint: Stay in the middle until everything settles. Then lure individuals out, and slingshot them into the hazards.\n\n", # Galaxy
"Don't take that bloody colonial advice about dodging around.\nNext they'll tell you to target officers.\n\n", # Galaxy
"???", # Galaxy
"Slip and fall down carefully.\n\n"], # Galaxy

["", "I can't bloody pronounce that bloke's name! Meter-Tron, Maethron, Me-", "", ""], # Metatron

# Engine
["", # Engine
"", # Engine
"", # Engine
"Use proper fuel. - You are the best.\nTop off lubricant. - You are the best.\nEnsure the carburetor is dried and clean. - You are the best.\nStart it by spinning without brutality. - You are the best.\n\n"], # Engine

["", "And how's Republican government working out for you?\n\n", "", ""], # Nebula

["", "", "", "Do not play whole eating this product.\n\n"], # Pandemonium

["", "", "", ""] # Custom
]
