# PokermonPlusPlus
This is an add-on mod for Pokermon, an add-on mod for Balatro. All credit goes to its creators, this is just a small idea I had for fun.<br />

This mod aims to add the ralts evolutive line and it's mega evolution<br />

-INSTALLATION-<br />
You need to have instaled pokermon beforehand https://github.com/InertSteak/Pokermon.<br />
1.- Download the zip and put it in your "%APPDATA%/Balatro/Mods" folder<br />
2.- In your Mods folder, find your pokermon installation and go to functions<br />
3.- Open file pokefunctions.lua with any text editor.<br />
4.- Add these lines to the file in line 283:<br />

if to_key == 'j_poke_mega_gardevoir' then to_key = 'j_euclashh_mega_gardevoir' end<br />
if to_key == 'j_poke_gardevoir' then to_key = 'j_euclashh_gardevoir' end<br />

![imagen](https://github.com/user-attachments/assets/7d8e2607-ce50-4614-aa71-d90b7b7bb260)
<br />
5.- Enjoy<br />
<br />
-SPOILERS-<br />
Joker effects:<br />
Ralts: Destroy leftmost consumable, 1/5 chance to create a negative copy of it at the end of round. Baby: X0.75 Mult. Blueprints copies will not destroy a card.
Kirlia: Destroy leftmost consumable, 1/4 chance to create a negative copy of it at the end of round. Adds a pink seal to leftmost played card. Blueprints copies will not destroy a card.
Gardevoir: Destroy leftmost consumable, 1/3 chance to create a negative copy of it at the end of round. If destroyed consumable is an spectral card, gain X1 Mult, otherwise gain X0.5. Blueprints copies will not destroy a card.
Mega-Gardevoir: 1/2 chance to create a negative copy of leftmost consumable at the end of round. Retrigger hand if it contains a pink seal.
