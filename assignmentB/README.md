## 作业2: 边缘检测和边缘链接:从你的图像中检测对象
### 要求：
本次作业中,你需要使用边缘检测方法来发现图中橡皮圈,笔帽等物体的边缘.由于实际场景中存在的噪声,照明不均导致的边缘中断,以及其它原因导致的灰度值的不连续使得边缘检测方法很少能得到完整清晰的边缘,所以边缘检测之后一般都需要边缘链接算法来将边缘像素点汇集起来形成有意义的边缘.
* 完成函数  my_edge.m 和 my_edgelinking.m  来获得上述的结果.你可以使用任意的边缘检测算法(算子)和边缘链接算法.
* 对于边缘检测,我们鼓励你使用不同的边缘检测方法并且比较它们的结果.我们鼓励你使用其它可以证明你的结果的图像.
* 对于边缘链接,你只需要对 rubberband_cap.png 这幅图像中的对象的边缘进行处理即可,你可以使用任意边缘链接方法.
在完成了你的边缘检测方法后,请用它生成上述中间图像所示的二值图像.然后,使用 imtool 函数来手工定位二值图像中某个对象边界中的某个像素点.
