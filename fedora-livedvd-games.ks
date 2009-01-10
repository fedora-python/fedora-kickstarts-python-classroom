# fedora-livedvd-games.ks
#
# Maintainer(s):
# - Rahul Sundaram <sundaram a fedoraunity.org>

%include fedora-livecd-desktop.ks

# The recommended part size for DVDs is too close to use for the games spin
part / --size 10240

%packages

# games

# traditional (big)

abuse
alienarena
armacycles-ad
asc
asc-music
astromenace
beneath-a-steel-sky-cd
blobAndConquer
boswars
bzflag
#croquet (pending)
crossfire-client
egoboo
extremetuxracer
FlightGear
flight-of-the-amazon-queen-cd
freeciv
freecol
freedoom
freedroidrpg
frozen-bubble
gl-117
glest
glob2
lincity-ng
manaworld
maniadrive
maniadrive-music
nethack-vultures
netpanzer
neverball
nexuiz
nogravity
openarena
pinball
scorched3d
supertux
supertuxkart
torcs
tremulous
ultimatestunts
# vdrift (Only works with binary drivers that won't be on the DVD)
warzone2100
wesnoth
widelands
worminator
wormux
xmoto

# traditional (small)

abe
alex4
ballz
blobwars
bolzplatz2006
bombardier
bsd-games
cdogs-sdl
clanbomber
clonekeen
foobillard
glaxium
gnubg
gnugo
hedgewars
lbrickbuster2
liquidwar
londonlaw
lure
machineball
nazghul-haxima
nethack
openlierox
pachi
pioneers
quake3
quake3-demo
quarry
Ri-li
rogue
rott-shareware
scorchwentbonkers
seahorse-adventures
solarwolf
sopwith
# starfighter (Removed from Fedora due to License)
stormbaancoureur
ularn
urbanterror
vavoom
worldofpadman
xblast

# arcade classics(ish) (big)

auriferous
alienblaster
duel3
lmarbles
powermanga
raidem
raidem-music
trackballs
trackballs-music
# uqm (uqm-data was removed due to license and 100MB is a bit much to download)
# uqm-content-3domusic
# uqm-content-voice

# arcade classics(ish) (small)

ballbuster
CriticalMass
dd2
KoboDeluxe
lacewing
Maelstrom
methane
njam
seahorse-adventures
shippy
tecnoballz
wordwarvi
#(xgalaga renamed)
xgalaxy
zasx

# falling blocks games (small) 

amoebax
crack-attack
crystal-stacker
fbg
gemdropx
gweled

# puzzles (big)
enigma
fillets-ng
pingus

# puzzles (small)

escape
magicor
mirrormagic
pipenightdreams
pipepanic
pychess
rocksndiamonds
vodovod

# card games

poker2d
PySolFC

# educational/simulation

bygfoot
celestia
childsplay
gcompris
planets
stellarium
tuxpaint
tuxpaint-stamps
tuxtype2

# kde based games
ksirk
poker2d-kde
taxipilot

# utilities

dosbox
games-menus
wget

%end

