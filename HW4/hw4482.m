%Test 1
clear; close all; clc;

Fs = 44100;
jazz = webread('https://files.freemusicarchive.org/storage-freemusicarchive-org/music/ccCommunity/Dee_Yan-Key/Lounge_Jazz_Symphony/Dee_Yan-Key_-_02_-_II_Intermezzo__Broadly.mp3');
jazz = mean(jazz.').';
jazz = jazz(1 : 5 * Fs);
electronic = webread('https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/Andrew_Codeman/Ice_Country/Andrew_Codeman_-_04_-_Run.mp3');
electronic = mean(electronic.').';
electronic = electronic(1:5 * Fs);
country = webread('https://files.freemusicarchive.org/storage-freemusicarchive-org/music/KBOO/miller_and/Live_at_KBOO_for_The_Noontime_Jamboree_08142017/miller_and_-_02_-_Miller_and_Sasser-Country_Song-Aug_2017-LIVE.mp3');
country = mean(country.').';
country = country(1:5 * Fs);

jspec = abs(spectrogram(jazz));
espec = abs(spectrogram(electronic));
cspec = abs(spectrogram(country));
[U,S,V] = svd([jspec espec cspec], 'econ');

