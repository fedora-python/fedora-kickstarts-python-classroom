# fedora-livedvd-games.ks
#
# Maintainer(s):
# - Bruno Wolff III <bruno@wolff.to>
# - Formerly maintained by Rahul Sundaram

%include fedora-livecd-desktop.ks

# The recommended part size for DVDs is too close to use for the games spin
part / --size 10240

%packages

# Wine pulls in i386 libraries under x86_86 making that spin too big.
# Also the point is to show off Fedora games, not running windows games.

-wine

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
# openarena (cut because of size, may be restored later if larger iso's allowed)
pinball
scorched3d
supertux
supertuxkart
torcs
tremulous
ultimatestunts
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

games-menus

%end
