# AI-Assignment2
# Working Demo of app:
link:https://youtu.be/4UCusRdHAok
# Intro
This app works exactly the same way as Silicon valley's "SeaFood" app , but instead of saying whether the food is a hot dog or not this app will tell us if it's a pizza or not. The code is divided into six sections and each section is explained below.

# First Steps
The first step was to incorporate the pretrained image recogonition model into my xcode project. The pre trained ML Model which I used was called InceptionV3 which was uploaded by apple to their developer site. This model detects dominant objects present in an image from a set of 1000 categories such as trees,foods,animals etc. After incorporating the model to my own project,Xcode automatically creates a model class.
# Basics
Now into the project, I imported two frameworks :
CoreML: Apple's machine learning framework (https://developer.apple.com/documentation/coreml) 
Vision: Vision helps to process images more easily and allows to use images to work with coreml without writing a lot of code.
Then I set up "UIImagePickerClass". This allows to tap into camera as well as choose image for image recogonition.

# Section1
I created new ImagePicker object then i set its delegate to the current working class. Then i set the source type to camera if the app was running on a virtual device else photo library(Simulator case). I did'nt allow editing of the image for simplicity. 
Now the task was when I wanted the image picker to appear, so the obvious part is when the camera is tapped, which is done in section3

# Section3
I'm presting the viewController as a imageviewController with some animations when the camera button is pressed

# Section2
Now the next task is what to do with the image?
 The image should be sent to the ML Model. To acheive this I added a delegate method. The delegate method comes from UIImagePickerController class. Now the image was loaded up as an UI Image.
 
# Section2.1
Here the image is converted into a CIImage(https://developer.apple.com/news/?id=tukbz962) which stands for core image image. It is a special type of image that allows to use vision framework and coreML framework in order to get classification.

# Section 4
This method process the CI Image and get a interpretation out of it. It takes one parameter which is a CI Image. Then I created a model using VNCoreMLModel as a container for my ml model(https://developer.apple.com/documentation/vision/vncoremlmodel). This is the model i used to classofy images. I used this model and called a VNCoreMlRequest(https://developer.apple.com/documentation/vision/vncoremlrequest). This either outputs results or error. I took the results and downcasted to an array of VNClassificationObservation( This is a class that holds classsification observation after the model is being processed.) Now the problem is the request doesn't know which image to perform classification on. This is solved in section 5)

# Secion5
I created a handler which specifies the image I wanted to classify( which in this case is the same image the user captured). Now using this handler I performed the request. Now if I run the app and a take/load up a picture I get  messed up datas as outputs. They are bunch of VNClassificationObservation objects and the first image is usually the image with higher confidence and will most likely be the user's image.

# Section 6
Here I'm just updating the UI if the picture was a pizza or not(the green and red backgrounds), After trying out with bunch of pictures the model performs pretty good.

# Note:
In case if you want to run this project in your own device, cloning and running wont work:(
Why?
Because the ml model is of size 95mb, but github did not allow me to upload a file which was greater than 95mb. In case if you want to test it out, let me know i will send you the ml model(It's just a matter of dragging and droping).

# THANK YOU


 
