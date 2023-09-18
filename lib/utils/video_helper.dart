import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:open_file/open_file.dart';

class VideoHelper {
  static final List fileFormat = ['.mp4', '.mov', '.m4v', '.3gpp'];
  static Future<List<File>> getVideoFiles() async {
    List<File> files = [];
    // Directory? directory = await getApplicationDocumentsDirectory();

    // print(directory);

    Directory? directory =
        Directory('/storage/emulated/0/Download/YoutubeDownloader');
    if (await directory.exists()) {
      List<FileSystemEntity> entities = directory.listSync(recursive: true);
      for (var entity in entities) {
        if (entity is File &&
            fileFormat.any((element) => entity.path.endsWith(element))) {
          files.add(entity);
        }
      }
    } else {
      directory.createSync(recursive: true);
    }
    return files;
  }

  static Future<String> getVideoThumbnail(String path) async {
    try {
      var thumbPath = await VideoThumbnail.thumbnailFile(
        video: path,

        // thumbnailPath: '/storage/emulated/0/Download/YoutubeDownloader/.temp',
        thumbnailPath: Platform.isAndroid
            ? '/storage/emulated/0/Download/YoutubeDownloader/.temp'
            : (await getApplicationDocumentsDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 360,
        quality: 25,
      );
      return thumbPath!;
    } catch (e) {
      e.toString();
    }
    return "";
  }

  static Future<void> launchInExternalPlayer(String url) async {
    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: url,
        type: "video/*",
      );
      await intent.launch();
    }
    if (Platform.isIOS) {
      // Directory documentsDir = await getApplicationDocumentsDirectory();
      // // Directory? documentsDir = await getExternalStorageDirectory();
      // String appDocumentsPath = documentsDir.path;
      //
      // // Construct the full path to the video file
      // String fullPath = '$appDocumentsPath/$url';
      // await GallerySaver.saveVideo(fullPath, albumName: "YourAlbumName");
      //
      // await OpenFile.open(fullPath, type: 'video');
      await OpenFile.open(url, type: 'video');

      // bool vlcInstalled =  OpenFile.openWith("org.videolan.vlc");

      // Open the video in VLC if installed, otherwise open in the gallery
      // if (vlcInstalled) {
      //   await OpenFile.open(url, type: 'video', uti: 'public.mpeg-4');
      // } else {
      //   await OpenFile.open(url, type: 'video');
      // }

      // Call the function with the provided URL
    }
  }
}
