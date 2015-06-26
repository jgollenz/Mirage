# Mirage
Advanced version of a "MagicMirror" for AS3 and Arduino


![My image](jgollenz.github.com/mirage/pictures/Main-Screen_2.JPG)

This project emerged from another project I had to do at my university.
Together with a colleague I had to make something with Arduino-sensors and Flash AS3.

Inspired by Michael Teeuw's "MagicMirror" (http://michaelteeuw.nl/tagged/magicmirror), I wanted to build one myself.
Great, but we still needed to use some sensors, it was a requirement for the project.
So I thought about how to make a touchscreen out of it. Until I read Michael's blog and how he said he didn't want smears
on a mirror. He is right. But what if you never even touch your screen to interact with it.
We are now using two sharp proximity sensors to track our hand(s) in front of the screen. 
The goal is to recognize (swipe-)gestures so that users can interact with the Mirage. 

We are now finished with the project for our university.
But I think it is way too cool to just scrap the idea afterwards. 
So I created this repository to remind myself not to do so and continue developing.
I am looking forward to buy all the materials (sensors & mirror were provided) myself and build one for my home.
Also, the code 
1.) needs to be reviewed and cleaned 
2.) is in ActionScript, what I consider not optimal. Maybe it can be rewritten in Processing or similar
