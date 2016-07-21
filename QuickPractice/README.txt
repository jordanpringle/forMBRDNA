Jordan Pringle for Mercedes-Benz RDNA
UI Software Engineer Position Homework

This is my first project using Qt/QML and my first time reading data from an XML document. 


Description:
Mercedes-Benz asked me to build a UI that displayed the top 100 songs currently on iTunes. Users should be able to select a song to hear a preview. 
In my interpretation of the task, I wanted to design a UI for a small infotainment screen in a car. Taking this choice into consideration, I decided to make the interface easy to read at a glace with few buttons and large touch zones while also being intuitive. The top banner of the screen incorporates a pause button for interrupting playback, a text field to display the name of the current song, and an image of the selected album artwork. Clicking the album artwork brings up a larger image of the same artwork and the background dims. Clicking anywhere at this point will close the larger album artwork and bring the main screen back into focus. Below the banner is a list view of all of the iTunes top 100 displayed in a slightly opaque background over a Mercedes-Benz logo. The selected song will be highlighted. 

To run:
Due to my limited knowledge of Qt, I suggest importing the project into Qt Creator and running the program from there. 

Enhancements:
In order to make this UI cleaner, more appealing, and easier to use, I would like to find a way to make sure the song titles do not overflow out of their containers but truncate and scroll when selected instead. Additionally, I would like to add a small version of the album artwork for each song within their containers in the list view. The pause button should have the ability to play the song after it has been paused with a corresponding change in appearance. Because I envision this UI being displayed on a small screen, I did not want to implement extraneous functionality that would get in the way of the overall use of the program. 


