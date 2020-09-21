import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:video_player/video_player.dart';

class MyMediaViewer extends StatefulWidget {
  final mediaUrl, mediaType;
  MyMediaViewer({Key key, this.mediaType, this.mediaUrl}) : super(key: key);
  @override
  _MyMediaViewerState createState() => _MyMediaViewerState();
}

class _MyMediaViewerState extends State<MyMediaViewer> {
  Widget fullScreenWidget;
  PDFDocument certiPdf;
  bool pdfLoaded = false;
  Widget pdfPage;
  bool videoLoaded = true, videoError = false;
  VideoPlayerController myVideoController;
  Widget noPreview = Center(
    child: Container(
      child: Text(
        'No Preview Available',
        style: TextStyle(color: Colors.black),
      ),
    ),
  );
  @override
  void dispose() {
    // TODO: implement dispose
    myVideoController.dispose();
    super.dispose();
  }

  void initState() {
    // TODO: implement initState

    if (widget.mediaType == 'pdf') {
      PDFDocument.fromURL(widget.mediaUrl).then((value) {
        setState(() {
          certiPdf = value;

          certiPdf.get().then((val) {
            print(widget.mediaUrl);
            setState(() {
              pdfPage = val;
              pdfLoaded = true;
              fullScreenWidget = pdfPage;
            });
          });
        });
      });
    } else if (widget.mediaType == 'mp4') {
      myVideoController = VideoPlayerController.network(widget.mediaUrl);
      myVideoController.addListener(() {
        if (myVideoController.value.hasError) {
          pdfLoaded = false;
          videoError = true;
        }

        setState(() {
          fullScreenWidget = Center(
            child: Scaffold(
              body: videoLoaded
                  ? Container(
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                        AspectRatio(
                          aspectRatio: myVideoController.value.aspectRatio,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: VideoPlayer(myVideoController),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: PlayPauseOverlay(
                            controller: myVideoController,
                          ),
                        ),
                      ]),
                    )
                  : noPreview,
            ),
          );
        });
        // myVideoController.setLooping(true);
      });
      myVideoController.initialize().then((value) {
        setState(() {
          pdfLoaded = true;
        });
      });
      myVideoController.setLooping(true);
      myVideoController.play();
    } else if (widget.mediaType == 'image') {
      setState(() {
        pdfLoaded = true;
        fullScreenWidget = Center(
          child: Container(
            child: FadeInImage(
              imageErrorBuilder: (context, Obj, stackTrc) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child:
                        Scaffold(body: Center(child: Text('Cant load imaage'))),
                  ),
                );
              },
              image: NetworkImage(widget.mediaUrl),
              placeholder: AssetImage('asets/loading1.gif'),
            ),
          ),
        );
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: !pdfLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : fullScreenWidget,
    );
  }
}

class PlayPauseOverlay extends StatelessWidget {
  const PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}
