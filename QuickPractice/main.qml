import QtQuick 2.7
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.6


ApplicationWindow {
    visible: true
    width: 800
    height: 600
    property alias page: page
    title: qsTr("Transitions")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: console.log("Open action triggered");
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
        }
    }

    //This Model grabs all of the song titles from the XML file

    XmlListModel {
         id: xmlModel
         source: "https://itunes.apple.com/us/rss/topsongs/limit=100/xml"
         query: "/feed/entry"
         namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"

         XmlRole { name: "title"; query: "title/string()" }
         /*
         onStatusChanged:{
             if(status == XmlListModel.Loading)
                 console.log("loading")
             if(status === XmlListModel.Ready)
                 console.log("loaded" + source)
             if(status === XmlListModel.Error)
                 console.log("Error" + errorString())
         }*/


     }

    //This Model grabs all of the urls for the previews of the songs

    XmlListModel {
         id: xmlModelPreviews
         source: "https://itunes.apple.com/us/rss/topsongs/limit=100/xml"
         query: "/feed/entry/link[2]"
         namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"


         XmlRole { name: "preview"; query: '@href/string()'}
         /*
         onStatusChanged:{
             if(status == XmlListModel.Loading)
                 console.log("loading")
             if(status === XmlListModel.Ready)
                 console.log("loaded" + source)
             if(status === XmlListModel.Error)
                 console.log("Error" + errorString())
         }*/


     }

    //This Model grabs all of the urls for the artwork of the songs

    XmlListModel {
         id: xmlModelArtwork
         source: "https://itunes.apple.com/us/rss/topsongs/limit=100/xml"
         namespaceDeclarations: "declare namespace im = 'http://itunes.apple.com/rss'; declare default element namespace 'http://www.w3.org/2005/Atom';"
             query: "/feed/entry"

         XmlRole { name: "artwork"; query: 'im:image[3]/string()'}
         /*
         onStatusChanged:{
             if(status == XmlListModel.Loading)
                 console.log("loading")
             if(status === XmlListModel.Ready)
                 console.log("loaded" + source)
             if(status === XmlListModel.Error)
                 console.log("Error" + errorString())
         }*/


     }



    Rectangle {         //Rectangle for creating and holding the ListView that contains the songs
        id: songs
        width: parent.width; height: parent.height
        anchors.topMargin: 100


        Component {
            id: contactDelegate
            Item {


                width: parent.width; height: page.height/6
                anchors.margins: 5

                Rectangle {
                    id: rect
                    color: "darkgrey"
                    anchors.fill: parent
                    opacity: 0.2
                    z: 0
                    anchors.margins: 10

                    radius: 5
                }

                Column {
                    //anchors.centerIn: parent
                    //anchors.left: parent
                    Text { text:  title      //writes the name of the song into the ListView
                            color: "white"
                            font.pixelSize: 30
                            maximumLineCount: 2
                            z: 1
                            leftPadding: 15
                            topPadding: page.height/20

                     }


                   }
                    MouseArea {                                //onClicked sets up the data for the preview, artwork and highlighting for the selected song
                        anchors.fill: parent
                        onClicked: {
                            songListView.currentIndex = index
                            songTopName.text = xmlModel.get(index).title
                            playMusic.source = xmlModelPreviews.get(index).preview
                            //console.log(xmlModelArtwork.get(index).artwork)
                            playMusic.play();
                            songImage.source = xmlModelArtwork.get(index).artwork
                            largeSongImage.source = xmlModelArtwork.get(index).artwork
                            songImage.z = 10

                        }
                    }


             }
         }
     }



Image {                              //background image of the Mercedes logo and name
    id: background
    source: "mercedesLarge.jpg"
    anchors.centerIn: parent
}

Rectangle {                         //top banner that contains small album artwork and playback controls
    id: topBanner
    color: "lightgrey"
    width: parent.width
    height: parent.height / 5
    z: 5
    gradient: Gradient {
        GradientStop { position: 0.0; color: "black" }
        GradientStop { position: 1.0; color: "lightgrey" }
    }

    Image {
        id: songImage
        source: "mercedes.jpg"
        height: 85
        width: 85
        state: "State2"
        x: parent.width *.85
        y: parent.height / 9
        z: 10
        MouseArea {
            anchors.fill: parent
            onClicked: {
                //songImage.state = "State1"

                largeSongImage.z = 10
                greyBack.z = 9

            }
        }

        StateGroup {
                      id: stateGroup
                      states: [
                          State {
                              name: "State1"

                              PropertyChanges {
                                  target: songImage
                                  x: page.width/2
                                  y: page.height/2
                                  height: 340
                                  width: 340
                              }
                          },
                          State {
                              name: "State2"
                              PropertyChanges {
                                  target: songImage
                                  x: parent.width *.80
                                  y: parent.height / 10
                                  height: 85
                                  width: 85
                              }
                          }
                      ]


        transitions:
            Transition {
                to: "*"
                NumberAnimation {
                    properties: "x,y,height,width";
                    duration: 200
                }
            }

    }

    }
    Image {
        id: playpause
        source: "pause.png"
        height: 85
        width: 85
        //anchors.left: parent
        anchors.leftMargin: 15
        y: topBanner.height/7
        x: page.width*.15 - playpause.width
        MouseArea {
            anchors.fill: parent
            onClicked: {
                    playMusic.pause()
            }
        }
    }
    Text {
        id: songTopName
        text: "iTunes Top 100"
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 40

    }


}


Image {                            //larger version of the song image to appear when small image version is clicked
    id: largeSongImage
    source: "mercedes.jpg"
    height: 340
    width: 340
    z: -10
    anchors.centerIn: parent
    MouseArea {
        anchors.fill: parent
        onClicked: {
            largeSongImage.z = -10
            greyBack.z = -1
        }
    }

}

Item {                                  //slightly opaque background to make reading song titles easier
    id: greyBack
    anchors.fill: parent
    opacity: 0.8
    z: -1
    Rectangle {
        height: parent.height
        width: parent.width
        color: "black"


    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            largeSongImage.z = -10
            greyBack.z = -1
        }
    }

}


Audio {                             //Audio setup to play music
        id: playMusic
    }



        ListView {                  //ListView of all the song titles
            id: songListView
            anchors.fill: parent
            anchors.topMargin: parent.height / 5
            model: xmlModel
            delegate: contactDelegate
            highlight: Rectangle { color: "darkred"; radius: 5 }

            focus: true

        }


    MainForm {
        anchors.fill: parent
        id: page

    }



    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
