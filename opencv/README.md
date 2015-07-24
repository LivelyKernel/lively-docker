1. Check out this repo
2. docker build --rm -t lively-server .
3. cd opencv
3. `docker build --rm -t lively-opencv .`
4. `cd ..`
5. `./start.sh`

You should then be able to use opencv, e.g. in s ServerWorkspace.

```js
var cv = require("opencv");
var path = require("path");

var testFolder = "/home/lively/LivelyKernel/opencv-test/";
var img = path.join(testFolder, "robert2.jpg");
var img = path.join(testFolder, "dan.jpg");
var resultImage = path.join(testFolder, "face-detection-result.jpg")

cv.readImage(img, function(err, image) {
  global.image = image;
  image.detectObject(cv.FACE_CASCADE, {}, function(err, faces){
    if (err) { console.error(err); return; }

    faces.forEach(function(face) {
      console.log("Found a face!", face);
      image.ellipse({
        center: {x: face.x + face.width/2, y: face.y + face.height/2},
        axes: {width: face.width/2, height: face.height/2},
        thickness: 5,
        color: [0, 255, 0]
      });
    });

    image.save(resultImage);
  });
});
```
