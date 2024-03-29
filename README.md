

## Flutter

## flutter环境搭建和Hello  Wrold

### 让Flutter跑起来

虚拟机运行以后，可以点击`debug`按钮，让Flutter程序跑起来。如果你幸运的话，你的Flutter程序经过编译后，就会跑起来了。（这种幸运的机会很小，总会碰到一些小错误，我在这里介绍两个常见的错误）。

### Error runing Gradle 错误解决（1.x版本已经修复）

在Debug项目的时候，应该最常见的错误就是类似下面这样的错误了。

```
Launching lib/main.dart on Android SDK built for x86 in debug mode...
Initializing gradle...
Resolving dependencies...
* Error running Gradle:
ProcessException: Process "/Users/rabbit/develop/android/flutter_app/android/gradlew" exited abnormally:
Project evaluation failed including an error in afterEvaluate {}. Run with --stacktrace for details of the afterEvaluate {} error.

FAILURE: Build failed with an exception.

* Where:
Build file '/Users/rabbit/develop/android/flutter_app/android/app/build.gradle' line: 25

* What went wrong:
A problem occurred evaluating project ':app'.
> Could not resolve all files for configuration 'classpath'.
   > Could not find lint-gradle-api.jar (com.android.tools.lint:lint-gradle-api:26.1.2).
     Searched in the following locations:
         https://jcenter.bintray.com/com/android/tools/lint/lint-gradle-api/26.1.2/lint-gradle-api-26.1.2.jar

* Try:
Run with --stacktrace option to get the stack trace. Run with --info or --debug option to get more log output. Run with --scan to get full insights.

* Get more help at https://help.gradle.org

BUILD FAILED in 0s
  Command: /Users/rabbit/develop/android/flutter_app/android/gradlew app:properties
Finished with error: Please review your Gradle project setup in the android/ folder.
```

这个问题的产生的原因，还是中国特有的问题，解决方案是改位阿里的链接(1.0已经修复了这个问题，不用再重新设置了)。

第一步：修改掉项目下的android目录下的`build.gradle`文件，把google() 和 jcenter()这两行去掉。改为阿里的链接。

```
maven { url 'https://maven.aliyun.com/repository/google' }
maven { url 'https://maven.aliyun.com/repository/jcenter' }
maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
```

全部代码：

```
buildscript {
    repositories {
        //  google()
        //  jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public'}
        }
        dependencies {
        classpath 'com.android.tools.build:gradle:3.1.2'
    }
}

allprojects {
    repositories {
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

注意是有两个部分进行了修改，不要只修改一处。

第二步：修改Flutter SDK包下的`flutter.gradle`文件,这个目录要根据你的SDK存放的位置有所变化。比如我放在了D盘Flutter目录下，那路径就是这个。

```
D:\Flutter\flutter\packages\flutter_tools\gradle
```

打开文件进行修改，修改代码如下（其实也是换成阿里的路径就可以了）。

```
buildscript {
    repositories {
        //jcenter()
        // maven {
        //     url 'https://dl.google.com/dl/android/maven2'
        // }
        maven{
            url 'https://maven.aliyun.com/repository/jcenter'
        }
        maven{
            url 'http://maven.aliyun.com/nexus/content/groups/public'
        }
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.1.2'
    }
}
```

然后再重新Debug一下，就基本可以启动起来。

还有一种错误是说硬件没有启动GPU，需要下载安装一个程序，这个提示的很清楚，不做过多的介绍了

### VSCode下如何玩转Flutter

### 一条命令快速开启虚拟机

现在想开启虚拟机需要打开`Android Studio`,然后再打开AVD虚拟机，我的电脑足足要等2分钟左右(土豪电脑除外)，我反正是不能接受的，一点不符合极客精神。下面就用一条命令，或者说制作一个批处理文件，来直接开启AVD虚拟机，这样就不用再等两分钟来开启`Android Studio`了。

**开启虚拟机需要两个步骤：**

1. 打开`emulator.exe`这个程序，你可以巧妙利用windows的查找工具进行查找。
2. 打开你设置的虚拟机，批处理时需要填写你设置的虚拟机名称。

**具体步骤如下：**

1. 新建一个`xxx.bat`文件到桌面，xxx的意思是，你可以自己取名字，随意叫什么都可以。我这里叫`EmulatorRun.bat`.
2. 查找`emulator.exe`文件的路径，把查找到的路径放到bat文件中，你一般会查找到两个emulator.exe文件，一个是在tools目录下，一个是在emulator目录下，我们选择`emulator`目录下的这个,复制它的路径。

```
C:\Users\Administrator\AppData\Local\Android\Sdk\emulator\emulator.exe
```

(特别说明，你的和我的很有可能不一样，你要复制i电脑中的路径，不要复制这里的代码)

1. 打开`Android Studio`，并查看你的AVD虚拟机名称 如果你觉的输入不方便和怕出错，你可以点击图片后边的笔型按钮，进入编辑模式，复制这个名称。 
2. 然后根据你复制的名称，把bat文件输入成如下形式。

```
C:\Users\Administrator\AppData\Local\Android\Sdk\emulator\emulator.exe -netdelay none -netspeed full -avd Nexus_5X_API_28
```

进行保存后双击bat文件，就可以迅速打开虚拟机了。

**参数解释：**

- -netdelay none :设置模拟器的网络延迟时间，默认为none，就是没有延迟。
- -netspeed full: 设置网络加速值，full代表全速。

### flutter run 开启预览

现在模拟器也有了，VSCode也支持Flutter开发了.现在可以在VSCode中直接打开终端，快捷键是`ctrl+~`，然后在终端中输入下面的命令。

```
flutter run
```

经过短暂的编译后就会启动我们的程序了（如图）。

到此处，终于搭建出了适合前端程序员的开发环境，下节课开始，我们正式来学习Flutter代码的编写知识。

我们来看几个重点的：

- r 键：点击后热加载，也就算是重新加载吧。
- p 键：显示网格，这个可以很好的掌握布局情况，工作中很有用。
- o 键：切换android和ios的预览模式。
- q 键：退出调试预览模式。

## Flutter常用 组件 

### Text Widget 文本组件的使用

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class  MyApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Text widget',
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello,widget,qewqeqweqweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
            textAlign: TextAlign.center,
            maxLines: 1,  //最大显示条数
            overflow: TextOverflow.ellipsis,  //fade 产生渐变 ellipsis 产生3个点 clip 全部隐藏
            style: TextStyle(
              fontSize: 25.0,
              color: Color.fromARGB(255, 255, 125, 125),
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      )
    );
  }
}
```

#### textAlign属性 

textAlign属性就是文本的对齐方式，它的属性值有如下几个：

- center: 文本以居中形式对齐,这个也算比较常用的了。
- left:左对齐，经常使用，让文本居左进行对齐，效果和start一样。
- right :右对齐，使用频率也不算高。
- start:以开始位置进行对齐，类似于左对齐。
- end: 以为本结尾处进行对齐，不常用。有点类似右对齐.

#### maxLines属性

设置最多显示的行数，比如我们现在只显示1行，   设置好即文字只显示一行

#### overflow属性

overflow属性是用来设置文本溢出时，如何处理,它有下面几个常用的值供我们选择。

- clip：直接切断，剩下的文字就没有了，感觉不太友好，体验性不好。
- ellipsis:在后边显示省略号，体验性较好，这个在工作中经常使用。
- fade: 溢出的部分会进行一个渐变消失的效果，当然是上线的渐变，不是左右的哦。

### style属性

style属性的内容比较多，具体的你可以查一下API

更详细的属性资料可以参看这个网址：https://docs.flutter.io/flutter/painting/TextStyle-class.html

### Container容器组件的使用

#### alignment属性

这个属性针对的是Container内child的对齐方式，也就是容器子内容的对齐方式，并不是容器本身的对齐方式。

- bottomCenter:下部居中对齐。
- botomLeft: 下部左对齐。
- bottomRight：下部右对齐。
- center：纵横双向居中对齐。
- centerLeft：纵向居中横向居左对齐。
- centerRight：纵向居中横向居右对齐。
- topLeft：顶部左侧对齐。
- topCenter：顶部居中对齐。
- topRight： 顶部居左对齐。

#### 设置宽、高和颜色属性

设置宽、高和颜色属性是相对容易的，只要在属性名称后面加入浮点型数字就可以了，比如要设置宽是500，高是400，颜色为亮蓝色。

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Text widget',
      home: Scaffold(
        body: Center(
          child: Container(
            child: new Text('Hello world', style: TextStyle(fontSize: 40.0)),
            alignment: Alignment.center,
            width: 500.0,
            height: 400.0,
            color: Colors.lightBlue,
          )
        ),
      )
    );
  }
}
```

#### padding属性

padding的属性就是一个内边距，它和你使用的前端技术CSS里的`padding`表现形式一样。

#### margin属性

margin是外边距，只的是container和外部元素的距离。

#### decoration属性

decoration是 container 的修饰器，主要的功能是设置背景和边框。

比如你需要给背景加入一个渐变，这时候需要使用BoxDecoration这个类

#### border属性

设置边框可以在decoration里设置border属性

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Text widget',
      home: Scaffold(
        body: Center(
          child: Container(
            child: new Text('Hello world', style: TextStyle(fontSize: 40.0)),
            alignment: Alignment.center,
            width: 500.0,
            height: 400.0,
            padding: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
            margin: const EdgeInsets.all(10.0),
            decoration: new BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.lightBlue,Colors.greenAccent,Colors.purple]
              ),
              border: Border.all(width: 2.0,color: Colors.red)
            ),
          )
        ),
      )
    );
  }
}
```

### Image图片组件的 使用

#### 加入图片的 方式

- **Image.asset**:加载资源图片，就是加载项目资源目录中的图片,加入图片后会增大打包的包体体积，用的是相对路径。
- **Image.network**:网络资源图片，意思就是你需要加入一段http://xxxx.xxx的这样的网络路径地址。
- **Image.file**:加载本地图片，就是加载本地文件中的图片，这个是一个绝对路径，跟包体无关。
- **Image.memory**: 加载Uint8List资源图片,这个我目前用的不是很多，所以没什么发言权。

#### fit属性的设置

fit属性可以控制图片的拉伸和挤压，这些都是根据图片的父级容器来的，我们先来看看这些属性（建议此部分组好看视频理解）。

- **BoxFit.fill**:全图显示，图片会被拉伸，并充满父容器。
- **BoxFit.contain**:全图显示，显示原比例，可能会有空隙。
- **BoxFit.cover**：显示可能拉伸，可能裁切，充满（图片要充满整个容器，还不变形）。
- **BoxFit.fitWidth**：宽度充满（横向充满），显示可能拉伸，可能裁切。
- **BoxFit.fitHeight** ：高度充满（竖向充满）,显示可能拉伸，可能裁切。
- **BoxFit.scaleDown**：效果和contain差不多，但是此属性不允许显示超过源图片大小，可小不可大。

#### repeat图片重复

- **ImageRepeat.repeat ** : 横向和纵向都进行重复，直到铺满整个画布。
- **ImageRepeat.repeatX **: 横向重复，纵向不重复。
- **ImageRepeat.repeatY **：纵向重复，横向不重复。

### listView组件的使用

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'listView widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text('listView widget')),
        body: new ListView(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.accessibility),
              title: new Text('accessibility'),
            ),
             new ListTile(
              leading: new Icon(Icons.adb),
              title: new Text('accessibility'),
            ),
          ],
        ),
      )
    );
  }
}
```

#### listView横向组件

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends  StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'listView widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text('listView widget')),
        body: Center(
          child: Container(
            height: 200.0,
            child: new ListView(
              scrollDirection: Axis.horizontal, // 横向 Axis.vertical //纵向
              children: <Widget>[
                new Container(
                  width: 180.0,
                  color: Colors.lightBlue,
                ),
                new Container(
                  width: 180.0,
                  color: Colors.amber, //黄色
                ),
                new Container(
                  width: 180.0,
                  color: Colors.deepPurple,
                ),
                new Container(
                  width: 180.0,
                  color: Colors.deepOrange,
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
```

#### listView动态列表

**List类型的使用**

List是Dart的集合类型之一,其实你可以把它简单理解为数组（反正我是这么认为的），其他语言也都有这个类型。它的声明有几种方式：

- `var myList = List()`: 非固定长度的声明。
- `var myList = List(2)`: 固定长度的声明。
- `var myList= List<String>()`:固定类型的声明方式。
- `var myList = [1,2,3]`: 对List直接赋值。

那我们这里使用的是一个List传递，然后直接用List中的`generate`方法进行生产List里的元素。最后的结果是生产了一个带值的List变量。代码如下：

```
void main () => runApp(MyApp(
  items: new List<String>.generate(1000, (i)=> "Item $i")
));
```

说明:再`main`函数的runApp中调用了MyApp类，再使用类的使用传递了一个`items`参数,并使用generate生成器对`items`进行赋值。

generate方法传递两个参数，第一个参数是生成的个数，第二个是方法

**接收参数**

我们已经传递了参数，那MyApp这个类是需要接收的。

```
final List<String> items;
MyApp({Key key, @required this.items}):super(key:key);
```

这是一个构造函数，除了Key，我们增加了一个必传参数，这里的`@required`意思就必传。`:super`如果父类没有无名无参数的默认构造函数，则子类必须手动调用一个父类构造函数。

这样我们就可以接收一个传递过来的参数了，当然我们要事先进行声明。

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp(
  items: new List<String>.generate(1000, (i) => "Item $i")
));

class MyApp extends StatelessWidget{
  final List<String> items;
  MyApp({Key key,@required this.items}):super(key:key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'listView widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text('listView widget')),
        body: new ListView.builder(
          itemCount: 1000,
          itemBuilder: (context, index) {
            return ListTile (
              title: new Text('${items[index]}'),
            );
          },
        )
      )
    );
  }
}
```

### GridView网格列表组件

我们在body属性中加入了网格组件，然后给了一些常用属性:

- padding:表示内边距，这个小伙伴们应该很熟悉。
- crossAxisSpacing:网格间的空当，相当于每个网格之间的间距。
- crossAxisCount:网格的列数，相当于一行放置的网格数量。

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'listView widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text('listView widget')),
        body: GridView.count(
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 3,
          children: <Widget>[
            const Text('I am sufan'),
            const Text('I love Web'),
            const Text('jspang.com'),
            const Text('我喜欢玩游戏'),
            const Text('我喜欢看书'),
            const Text('我喜欢吃火锅')
          ],
        )
      )
    );
  }
}

```

#### 图片网格

- childAspectRatio:宽高比，这个值的意思是宽是高的多少倍，如果宽是高的2倍，那我们就写2.0，如果高是宽的2倍，我们就写0.5。希望小伙伴们理解一下。

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'listView widget',
      home: Scaffold(
        appBar: new AppBar(title: new Text('listView widget')),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 0.7
          ),
          children: <Widget>[
            new Image.network('http://img5.mtime.cn/mt/2018/10/22/104316.77318635_180X260X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/10/10/112514.30587089_180X260X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/13/093605.61422332_180X260X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/07/092515.55805319_180X260X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/21/090246.16772408_135X190X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/17/162028.94879602_135X190X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/19/165350.52237320_135X190X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/16/115256.24365160_180X260X4.jpg',fit: BoxFit.cover),
             new Image.network('http://img5.mtime.cn/mt/2018/11/20/141608.71613590_135X190X4.jpg',fit: BoxFit.cover),
          ],
        )
      )
    );
  }
}
```

### rowWidget布局

#### 不灵活布局

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'row widget Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title: new Text('水平方向布局'),
        ),
        body: new Row(
          children: <Widget>[
            new RaisedButton(
              onPressed: () {},
              color: Colors.redAccent,
              child: new Text('red Button'),
            ),
            new RaisedButton(
              onPressed: () {},
              color: Colors.orangeAccent,
              child: new Text('orange Button'),
            ),
            new RaisedButton(
              onPressed: () {},
              color: Colors.pinkAccent,
              child: new Text('pink Button'),
            ),
          ],
        ),
      ),
    );
  }
}
```

这时候你会发现的页面已经有了三个按钮，但这三个按钮并没有充满一行，而是出现了空隙。这就是不灵活横向排列造成的。它根据子元素的大小来进行排列。如果我们想实现充满一行的效果，就要使用灵活水平布局了。

#### 灵活布局

```
Expanded(child:
    new RaisedButton(
    onPressed: () {},
    color: Colors.redAccent,
    child: new Text('red Button'),
  ),
),
```

### 垂直布局Column组件

#### column基本用法

左对齐只要在column组件下加入下面的代码，就可以让文字左对齐。

```
crossAxisAlignment: CrossAxisAlignment.start,
```

- CrossAxisAlignment.star：居左对齐。
- CrossAxisAlignment.end：居右对齐。
- CrossAxisAlignment.center：居中对齐。

#### 主轴和副轴的认识

在设置对齐方式的时候你会发现右mainAxisAlignment属性，意思就是主轴对齐方式，那什么是主轴，什么又是幅轴那。

- main轴：如果你用column组件，那垂直就是主轴，如果你用Row组件，那水平就是主轴。
- cross轴：cross轴我们称为幅轴，是和主轴垂直的方向。比如Row组件，那垂直就是幅轴，Column组件的幅轴就是水平方向的。

主轴和幅轴我们搞清楚，才能在实际工作中随心所欲的进行布局。

比如现在我们要把上面的代码，改成垂直方向居中。因为用的是Column组件，所以就是主轴方向，这时候你要用的就是主轴对齐了。

```
mainAxisAlignment: MainAxisAlignment.center,
```

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'row widget Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title: new Text('水平方向布局'),
        ),
        body:Center(child:
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(child:  Text('sufan sufan')),
              Expanded (child: Text('flutter 是未来的发展方向')),
              Text('I love coding')
            ],
          )
        )
      ),
    );
  }
}
```



### stack重叠布局

#### 层叠布局的 alignment 属性

alignment属性是控制层叠的位置的，建议在两个内容进行层叠时使用。它有两个值X轴距离和Y轴距离，值是从0到1的，都是从上层容器的左上角开始算起的。

#### CircleAvatar组件的使用

`CircleAvatar`这个经常用来作头像的，组件里边有个`radius`的值可以设置图片的弧度。

现在我们准备放入一个图像，然后把弧度设置成100，形成一个漂亮的圆形，代码如下：

```
new CircleAvatar(
  backgroundImage: new NetworkImage('http://jspang.com/static//myimg/blogtouxiang.jpg'),
  radius: 100.0,
),
```

```
import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var stack = new Stack(
      alignment: const FractionalOffset(0.5, 0.8),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage('http://blogimages.jspang.com/blogtouxiang1.jpg'),
          radius: 100,
        ),
        new Container(
          decoration: new BoxDecoration(
            color: Colors.lightBlue
          ),
          padding: EdgeInsets.all(10.0),
          child: Text('sufan'),
        )
      ],
    );
    return MaterialApp(
      title: 'row widget Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title: new Text('stack布局'),
        ),
        body:Center(
          child: stack,
        )
      ),
    );
  }
}
```

#### Stack的Positioned属性

### Positioned组件的属性

- bottom: 距离层叠组件下边的距离
- left：距离层叠组件左边的距离
- top：距离层叠组件上边的距离
- right：距离层叠组件右边的距离
- width: 层叠定位组件的宽度
- height: 层叠定位组件的高度

```
new Positioned(
  top: 10.0,
  left: 10.0,
  child: new Text('1111111111'),
),
new Positioned(
  bottom: 10.0,
  right: 10.0,
  child: new Text('222222222'),
)
```

### 卡片组件布局

```
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var card = new Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('山西省晋城市陵川县', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('苏凡：2222222222222'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue),
          ),
          new Divider(),
          ListTile(
            title: Text('陕西省西安市', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('苏222：222221311'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue),
          ),
          new Divider(),
          ListTile(
            title: Text('北京市', style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('苏3333：222221311'),
            leading: new Icon(Icons.account_box, color: Colors.lightBlue),
          ),
        ],
      ),
    );
    return MaterialApp(
      title: 'row widget Demo',
      home: Scaffold(
        appBar:  new AppBar(
          title: new Text('stack布局'),
        ),
        body:Center(
          child: card,
        )
      ),
    );
  }
}
```

### 一般页面导航和返回

#### RaisedButton按钮组件

它有两个最基本的属性：

- child：可以放入容器，图标，文字。让你构建多彩的按钮。
- onPressed：点击事件的相应，一般会调用`Navigator`组件。

我们在作页面导航时，大量的使用了`RaisedButton`组件，这个组件的使用在实际工作中用的也比较多。

#### Navigator.push 和 Navigator.pop

- `Navigator.push`：是跳转到下一个页面，它要接受两个参数一个是上下文`context`，另一个是要跳转的函数。
- `Navigator.pop`：是返回到上一个页面，使用时传递一个context（上下文）参数，使用时要注意的是，你必须是有上级页面的，也就是说上级页面使用了`Navigator.push`。

```
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: '导航演示01',
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('导航页面')),
      body: Center(
        child: RaisedButton(
          child: Text('查看商品想起页'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => new SecondScreen()
            ));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('商品详情页')),
      body: Center(
        child: RaisedButton(
          child: Text('返回'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
```

### 导航参数的传递和接收

#### 声明数据结构

Dart中可以使用类来抽象一个数据，比如我们模仿一个商品信息，有商品标题和商品描述。我们定义了一个Product类，里边有两个字符型变量，title和description。

- title:是商品标题。
- description: 商品详情描述

代码如下:

```
class Product{
  final String title;  //商品标题
  final String description;  //商品描述
  Product(this.title,this.description);
}
```

### 构建一个商品列表

作一个商品的列表，这里我们采用动态的构造方法，在主方法里传递一个商品列表（List）到自定义的Widget中。

先来看看主方法的编写代码:

```
void main(){
  runApp(MaterialApp(
    title:'数据传递案例',
    home:ProductList(
      products:List.generate(
        20, 
        (i)=>Product('商品 $i','这是一个商品详情，编号为:$i')
      ),
    )
  ));
}
```

上面的代码是主路口文件，主要是在home属性中，我们使用了ProductList，这个自定义组件，而且时候会报错，因为我们缺少这个组件。这个组件我们传递了一个products参数，也就是商品的列表数据，这个数据是我们用`List.generate`生成的。并且这个生成的List原型就是我们刚开始定义的Product这个类（抽象数据）。

ProductList自定义组件的代码：

```
class ProductList extends StatelessWidget{
  final List<Product> products;
  ProductList({Key key,@required this.products}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('商品列表')),
      body:ListView.builder(
        itemCount:products.length,
        itemBuilder: (context,index){
          return ListTile(
            title:Text(products[index].title),
            onTap:(){
            }
          );
        },
      )
    );
  }
}

```

先接受了主方法传递过来的参数，接受后用`ListView.builder`方法，作了一个根据传递参数数据形成的动态列表。

#### 导航参数的传递

我们还是使用`Navigator`组件，然后使用路由`MaterialPageRoute`传递参数，具体代码如下。

```
Navigator.push(
  context, 
  MaterialPageRoute(
    builder:(context)=>new ProductDetail(product:products[index])
  )
);

```

这段代码要写在onTap相应事件当中。这时候`ProductDetail`会报错，因为我们还没有生命这个组件或者说是类。

#### 子页面接受参数并显示

现在需要声明`ProductDetail`这个类（组件），先要作的就是接受参数，具体代码如下。

```
class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key ,@required this.product}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title:Text('${product.title}'),
      ),
      body:Center(child: Text('${product.description}'),)
    );
  }
}

```

先接受了参数，并把数据显示在了页面中。

```javascript
import 'package:flutter/material.dart';

class Product {
  final String title; //商品标题
  final String description; //商品描述
  Product(this.title, this.description);
}
void main() {
  runApp(MaterialApp(
    title: '导航的数据传递和接收',
    home: ProductList(
      products: List.generate(20, (i) => Product('商品 $i', '这是一个商品详情，编号为：$i'))
    ),
  ));
}

class ProductList extends StatelessWidget {
  final List<Product>products;
  ProductList({Key key,@required this.products}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品列表')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index) {
          return ListTile(
            title: Text(products[index].title),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetail(product:products[index])
              ));
            },
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key, @required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${product.title}')),
      body: Center(child: Text('${product.description}'))
    );
  }
}
```

### 页面跳转并返回数据

#### 异步等待请求

### 异步请求和等待

Dart中的异步请求和等待和ES6中的方法很像，直接使用async...await就可以实现。比如下面作了一个找小姐姐的方法，然后进行跳转，注意这时候是异步的。等待结果回来之后，我们再显示出来内容。具体代码如下：

```
  _navigateToXiaoJieJie(BuildContext context) async{ //async是启用异步方法

    final result = await Navigator.push(//等待
      context, 
      MaterialPageRoute(builder: (context)=> XiaoJieJie())
      );
      
      Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));
  }
}
```

#### SnackBar的使用

`SnackBar`是用户操作后，显示提示信息的一个控件，类似`Tost`，会自动隐藏。`SnackBar`是以`Scaffold`的`showSnackBar`方法来进行显示的。

```
Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));
```

### 返回数据的方式

返回数据其实是特别容易的，只要在返回时带第二个参数就可以了。

```
 Navigator.pop(context,'xxxx');  //xxx就是返回的参数
```

```
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: '页面跳转并返回数据',
      home: FirstPage()
    )
  );
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('找小姐姐要电话')),
      body: Center(
        child: RouteButton(),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigatoToXiaoJieJie(context);
      },
      child: Text('去找小姐姐'),
    );
  }
  _navigatoToXiaoJieJie(BuildContext context) async{
    final result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => XiaoJieJie()
    ));
    Scaffold.of(context).showSnackBar(SnackBar(content:Text('$result')));
  }
}

class XiaoJieJie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(title: Text('小姐姐')),
      body: Center(
        child:Column(
          children: <Widget>[
            RaisedButton(
              child: Text('大长腿小姐姐'),
              onPressed: () {
                Navigator.pop(context, '大长腿小姐姐：1510123456');
              },
            ),
            RaisedButton(
              child: Text('小蛮腰小姐姐'),
              onPressed: () {
                Navigator.pop(context, '小蛮腰小姐姐：15188888888');
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

### 静态资源和项目图片的处理

配置pubspec.yaml 下面的assets

## Flutter客户端打包





## Flutter小型demo

### 底部导航栏的制作

**主入口文件编写**

首先我们先写一个主入口文件，这个文件只是简单的APP通用结构，最主要的是要引入自定义的`BottomNavigationWidget`组件。

```
import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';
void main () => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter bottomNavigationBar',
      theme: ThemeData.light(),
      home: BottomNavgationWidget(),
    );
  }
}
```

### StatefulWidget 讲解

在编写`BottomNaivgationWidget`组件前，我们需要简单了解一下什么是`StatefulWidget`.

`StatefulWidget`具有可变状态(state)的窗口组件（widget）。使用这个要根据变化状态，调整State值。

在lib目录下，新建一个`bottom_navigation_widget.dart`文件。

它的初始化和以前使用的`StatelessWidget`不同，我们在VSCode中直接使用快捷方式生成代码（直接在VSCode中输入stful）：

```
class name extends StatefulWidget {
  _nameState createState() => _nameState();
}

class _nameState extends State<name> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: child,
    );
  }
}

```

上面的代码可以清楚的看到，使用`StatefulWidget`分为两个部分，第一个部分是继承与`StatefullWidget`，第二个部分是继承于`State`.其实`State`部分才是我们的重点，主要的代码都会写在`State`中。

**子页面的编写**

```
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('HOME'),
      ),
      body:Center(
        child: Text('HOME'),
      )
    );
  }
}
```

#### 重写initState()方法

我们要重新`initState()`方法，把刚才做好的页面进行初始化到一个Widget数组中。有了数组就可以根据数组的索引来切换不同的页面了。这是现在几乎所有的APP采用的方式。

代码如下:

```
 List<Widget> list = List();
 @override
 void initState(){
    list
      ..add(HomeScreen())
      ..add(EmailScreen())
      ..add(PagesScreen())
      ..add(AirplayScreen());
    super.initState();
  }
```

这里的`..add()`是Dart语言的..语法，如果你学过编程模式，你一定听说过建造者模式，简单来说就是返回调用者本身。这里list后用了..add()，还会返回list，然后就一直使用..语法，能一直想list里增加widget元素。 最后我们调用了一些父类的`initState()`方法

```
import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/email_screen.dart';
import 'pages/pages_screen.dart';
import 'pages/airplay_screen.dart';

class BottomNavgationWidget extends StatefulWidget {
  _BottomNavgationWidgetState createState() => _BottomNavgationWidgetState();
}

class _BottomNavgationWidgetState extends State<BottomNavgationWidget> {
  final _BottomNavgationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> bottomList = List();

  @override
  void initState() {
    bottomList
      ..add(HomeScreen()) //构造者模式
      ..add(EmailScreen())
      ..add(PagesScreen())
      ..add(AirplayScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _BottomNavgationColor
            ),
            title: Text(
              'home',
              style: TextStyle(color:_BottomNavgationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _BottomNavgationColor
            ),
            title: Text(
              'Email',
              style: TextStyle(color:_BottomNavgationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _BottomNavgationColor
            ),
            title: Text(
              'Pages',
              style: TextStyle(color:_BottomNavgationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _BottomNavgationColor
            ),
            title: Text(
              'Airplay',
              style: TextStyle(color:_BottomNavgationColor),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

```

### 不规则底部工具栏

#### 自定义主题样本

Flutter支持自定义主题，如果使用自定义主题，设置的内容项是非常多的，这可能让初学者头疼，Flutter贴心的为给我们准备了主题样本。

> primarySwatch ：现在支持18种主题样本了。

具体代码如下：

```
theme: ThemeData(
  primarySwatch: Colors.lightBlue,
),
```

### floatingActionButton Widget

`floatingActionButton`工作中我们通常简称它为“FAB”，也许只是我们公司这样称呼，从字面理解可以看出，它是“可交互的浮动按钮”,其实在Flutter默认生成的代码中就有这家伙，只是我们没有正式的接触。

一般来说，它是一个圆形，中间放着图标，会优先显示在其他Widget的前面。

下面我们来看看它的常用属性:

- onPressed ：点击相应事件，最常用的一个属性。
- tooltip：长按显示的提示文字，因为一般只放一个图标在上面，防止用户不知道，当我们点击长按时就会出现一段文字性解释。非常友好，不妨碍整体布局。
- child ：放置子元素，一般放置Icon Widget。

我们来看一下`floatingActionButton`的主要代码:

```
floatingActionButton: FloatingActionButton(
    onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
        return EachView('New Page');
      }));
    },
    tooltip: 'Increment',
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
  ),

```

写完这些代码已经有了一个悬浮的按钮，但这个悬浮按钮还没有和低栏进行融合，这时候需要一个属性。

```
floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
```

这时候就可以和底栏进行融合了。

### BottomAppBar Widget

`BottomAppBar` 是 底部工具栏的意思，这个要比`BottomNavigationBar` widget灵活很多，可以放置文字和图标，当然也可以放置容器。

`BottomAppBar`的常用属性:

- color:这个不用多说，底部工具栏的颜色。
- shape：设置底栏的形状，一般使用这个都是为了和`floatingActionButton`融合，所以使用的值都是CircularNotchedRectangle(),有缺口的圆形矩形。
- child ： 里边可以放置大部分Widget，让我们随心所欲的设计底栏。

这节课先来看看这个布局，下节课我们再添加交互效果。

### StatefulWidget子页面的制作

新建一个`each_view.dart`文件，然后输入如下代码：

```
import 'package:flutter/material.dart';

class EachView extends StatefulWidget {
  String _title;
  EachView(this._title);
  @override
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text(widget._title),),
       body: Center(child: Text(widget._title),),
    );
  }
}

```

```
import 'package:flutter/material.dart';
import 'each_view.dart';

class BottomAppBarDemo extends StatefulWidget {
  _BottomAppBarDemoState createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  List<Widget> _eachView;
  int _index = 0;
  @override
  void initState() {
    super.initState();
    _eachView = List();
    _eachView..add(EachView('Home'))..add(EachView('sufan'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _eachView[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
            return EachView('New page');
          }));
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          color: Colors.white
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color:Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.airport_shuttle),
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

```

### 自定义路由的动画

#### 主入口文件

```
import 'package:flutter/material.dart';
import 'pages.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      // 自定义主题
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: FirstPage(),
    );
  }
}

```

#### pages.dart文件的编写

**elevation 属性**

这个值是AppBar 滚动时的融合程度，一般有滚动时默认是4.0，现在我们设置成0.0，就是和也main完全融合了。

```
import 'package:flutter/material.dart';
import 'custome_router.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('FirstPage', style: TextStyle(fontSize: 36.0),),
        elevation: 0.0,
      ),
      body: Center(
        child: MaterialButton(
            child: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: 64.0
            ),
            onPressed: () {
              Navigator.of(context).push(CustomeRoute(SecondPage()));
            },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text('SecodPage', style: TextStyle(fontSize: 36.0)),
        backgroundColor: Colors.pinkAccent,
        elevation: 0.0,
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(
            child: Icon(
              Icons.navigate_next,
              color: Colors.white,
              size: 64.0
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
      ),
    );
  }
}

```

#### 自定义Custome Widget

新建一个`custome_router.dart`文件，这个就是要自定义的路由方法，自定义首先要继承于通用的路由的构造器类`PageRouterBuilder`。继承之后重写父类的`CustomRoute`构造方法。

构造方法可以简单理解为：只要以调用这个类或者说是Widget，构造方法里的所有代码就执行了。

- FadeTransition:渐隐渐现过渡效果，主要设置opactiy（透明度）属性，值是0.0-1.0。
- animate :动画的样式，一般使用动画曲线组件（CurvedAnimation）。
- curve: 设置动画的节奏，也就是常说的曲线，Flutter准备了很多节奏，通过改变动画取消可以做出很多不同的效果。
- transitionDuration：设置动画持续的时间，建议再1和2之间。

```
import 'package:flutter/material.dart';

class CustomeRoute extends PageRouteBuilder {
  final Widget widget;
  CustomeRoute(this.widget):super(
    transitionDuration:const Duration(seconds: 2),
    pageBuilder:(
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2
      ) {
        return widget;
    },
    transitionsBuilder:(
      BuildContext context,
      Animation<double> animation1,
      Animation<double> animation2,
      Widget child){
        return FadeTransition(
          opacity: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
    }
  );
}

```

#### 缩放路由动画

```
return ScaleTransition(
 scale:Tween(begin:0.0,end:1.0).animate(CurvedAnimation(
    parent:animation1,
    curve: Curves.fastOutSlowIn
    )),
    child:child
);
```

#### 旋转+缩放路由动画

```
return RotationTransition(
  turns:Tween(begin:0.0,end:1.0)
  .animate(CurvedAnimation(
    parent: animation1,
    curve: Curves.fastOutSlowIn
  )),
  child:ScaleTransition(
    scale:Tween(begin: 0.0,end:1.0)
    .animate(CurvedAnimation(
        parent: animation1,
        curve:Curves.fastOutSlowIn
    )),
    child: child,
  )
);
```

#### 左右滑动动画

```
return SlideTransition(
  position: Tween<Offset>(
    begin: Offset(-1.0, 0.0),
    end:Offset(0.0, 0.0)
  )
  .animate(CurvedAnimation(
    parent: animation1,
    curve: Curves.fastOutSlowIn
  )),
  child: child,
);
```

### 毛玻璃效果制作

#### main.dart文件编写

```
import 'package:flutter/material.dart';
import 'FrostedGlassDemo.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      // 自定义主题
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: FrostedGlassDemo(),
    );
  }
}

```

### BackdropFilter Widget

`BackdropFilter`就是背景滤镜组件，使用它可以给父元素增加滤镜效果，它里边最重要的一个属性是`filter`。 `filter`属性中要添加一个滤镜组件，实例中我们添加了图片滤镜组件，并给了模糊效果。

#### froatedGlassDemo.dart文件

```
import 'package:flutter/material.dart';
import 'dart:ui';  //使用顾虑器

class FrostedGlassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( //重叠组件
        children: <Widget>[
          ConstrainedBox( //约束盒子，添加额外的约束条件再child上
            constraints: const BoxConstraints.expand(),
            child: Image.network('http://pic37.nipic.com/20140113/8800276_184927469000_2.png'),
          ),
          Center(
            child: ClipRect( //可裁切矩形
              child: BackdropFilter( //背景过滤器
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: 500.0,
                    height: 700.0,
                    decoration: BoxDecoration(color: Colors.grey.shade200), //盒子修饰器
                    child: Center(
                      child: Text(
                        'sufan',
                        style: Theme.of(context).textTheme.display3,
                      ),
                    ),
                  ),
                )
              )
            ),
          ),
        ]
      ),
    );
  }
}

```

### 保持页面的状态

#### with关键字的使用

with是dart的关键字，意思是混入的意思，就是说可以将一个或者多个类的功能添加到自己的类无需继承这些类， 避免多重继承导致的问题。

```
class _KeepAliveDemoState extends State<KeepAliveDemo> with SingleTickerProviderStateMixin {

}
```

### TabBar Widget的使用

TabBar是切换组件，他需要设置连个属性

- controller控制器，后面跟的的对个TabCOntroller组件
- tabs具体切换项是一个数组，里面放 的也是TabWidget

```
bottom:TabBar(
  controller: _controller,
  tabs:[
    Tab(icon:Icon(Icons.directions_car)),
    Tab(icon:Icon(Icons.directions_transit)),
    Tab(icon:Icon(Icons.directions_bike)),
  ],
)
```

#### main.dart主文件编码

```
import 'package:flutter/material.dart';
import 'keep_alive_demo.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: KeepAliveDemo(),
    );
  }
}

class KeepAliveDemo extends StatefulWidget {
  _KeepAliveDemoState createState() => _KeepAliveDemoState();
}
class _KeepAliveDemoState extends State<KeepAliveDemo> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this); // 垂直  使用vsync 必须使用SingleTickerProviderStateMixin  with 是dart中的关键字 意思混入的意思 就是实说可以将一些或者多个类的功能添加到自己的类无需继承这些类 SingleTickerProviderStateMixin 主要是我们初始化TabController时，需要用到vsync ，垂直属性，然后传递this
  }
  @override
  void dispose() {
    _controller.dispose(); //重写销毁方法
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('keep alive demo'),
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.directions_car),),
            Tab(icon: Icon(Icons.directions_bus),),
            Tab(icon: Icon(Icons.directions_bike),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          MyHomePage(),
          MyHomePage(),
          MyHomePage(),
        ],
      ),
    );
  }
}

```

#### keepAliveDar.dart文件的编写

```
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AutomaticKeepAliveClientMixin {
  int _counter = 0;
  @override
  bool get wantKeepAlive => true;  //重写方法

  @override
  void _incrementCounter() {
    setState(() {
     _counter ++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('点一次增加一个数字'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

```

### 一个不简单的搜索条

#### 主入口文件

```
import 'package:flutter/material.dart';
import 'search_bar_demo.dart';

void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme: ThemeData.light(),
      home: SearchBarDemo()
    );
  }
}
```

#### 数据文件asset.dart

`asset.dart`相当于数据文件，工作中这些数据是后台传递给我们，或者写成配置文件的，这里我们就以List的方式代替了。我们在这个文件中定义了两个List：

- searchList : 这个相当于数据库中的数据，我们要在这里进行搜索。
- recentSuggest ： 目前的推荐数据，就是搜索时，自动为我们进行推荐。

```
const searchList = [
  "jiejie-大长腿",
  "jiejie-水蛇腰",
  "gege-帅气欧巴",
  "gege-小鲜肉"
];

const recentSuggest = [
  "推荐-1",
  "推荐-2"
];

```

#### 重写buildActions方法

`buildActions`方法时搜索条右侧的按钮执行方法，我们在这里方法里放入一个clear图标。 当点击图片时，清空搜索的内容。

```
@override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: ()=>query = "",)
      ];
  }
```

#### buildLeading方法重写

这个时搜索栏左侧的图标和功能的编写，这里我们才用`AnimatedIcon`，然后在点击时关闭整个搜索页面，代码如下。

```
@override
Widget buildLeading(BuildContext context){
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,progress: transitionAnimation,
      ),
      onPressed: () => close(context, null)
    );
 }
```

#### buildResults方法重写

`buildResults`方法，是搜到到内容后的展现，因为我们的数据都是模拟的，所以我这里就使用最简单的`Container`+`Card`组件进行演示了，不做过多的花式修饰了。

```
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }
```

#### buildSuggestions方法重写

这个方法主要的作用就是设置推荐，就是我们输入一个字，然后自动为我们推送相关的搜索结果，这样的体验是非常好的。

```
@override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty? recentSuggest : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight:FontWeight.bold
            ),
            children: [
              TextSpan(
                text:suggestionList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey
                )
              )
            ]
          ),
        ),
      ),
    );
  }
```

#### search_bar_demo.dart文件的代码

```
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'asset.dart';

class SearchBarDemo extends StatefulWidget {
  _SearchBarDemoState createState() => _SearchBarDemoState();
}

class _SearchBarDemoState extends State<SearchBarDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search Demo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: searchBarDelegate());
            },
          )
        ],
      ),
    );
  }
}

class searchBarDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon:Icon(Icons.clear),
        onPressed: () => query = ""
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,progress: transitionAnimation,
      ),
      onPressed: () => close(context, null)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty? recentSuggest : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
              color: Colors.black,
              fontWeight:FontWeight.bold
            ),
            children: [
              TextSpan(
                text:suggestionList[index].substring(query.length),
                style: TextStyle(
                  color: Colors.grey
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

```

### 流式布局 模拟添加照片效果

#### mediaQuery媒体查询

使用`meidaQuery`可以很容易的得到屏幕的宽和高，得到宽和高的代码如下：

```
final width = MediaQuery.of(context).size.width;
final height = MediaQuery.of(context).size.height;
```

#### Wrap流式布局

Flutter中流式布局大概有三种常用方法，这节课先学一下Wrap的流式布局。有的小伙伴会说Wrap中的流式布局可以用Flow很轻松的实现出来，但是Wrap更多的式在使用了Flex中的一些概念，某种意义上说式跟Row、Column更加相似的。

单行的Wrap跟Row表现几乎一致，单列的Wrap则跟Column表现几乎一致。但Row与Column都是单行单列的，Wrap则突破了这个限制，mainAxis上空间不足时，则向crossAxis上去扩展显示。

从效率上讲，Flow肯定会比Wrap高，但Wrap使用起来会更方便一些。

这个会在实例中用到，所以，我在实例中会讲解这个代码。

#### getureDetector手势操作

`GestureDetector`它式一个Widget，但没有任何的显示功能，而只是一个手势操作，用来触发事件的。虽然很多Button组件是有触发事件的，比如点击，但是也有一些组件是没有触发事件的，比如：Padding、Container、Center这时候我们想让它有触发事件就需要再它们的外层增加一个`GestureDetector`，比如我们让Padding有触发事件，代码如下：

```
Widget buildAddButton(){
    return  GestureDetector(
      onTap:(){
        if(list.length<9){
          setState(() {
                list.insert(list.length-1,buildPhoto());
          });
        }
      },
      child: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.black54,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
```

#### 主入口文件

```
import 'package:flutter/material.dart';
import 'warp_demo.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData.dark(),
      home:WarpDemo()
    );
  }
}
```

#### wrap_demo.dart

```
import 'package:flutter/material.dart';


//继承与动态组件
class WarpDemo extends StatefulWidget {
  _WarpDemoState createState() => _WarpDemoState();
}

class _WarpDemoState extends State<WarpDemo> {
  List<Widget> list;  //声明一个list数组

  @override
  //初始化状态，给list添加值，这时候调用了一个自定义方法`buildAddButton`
  void initState() { 
    super.initState();
    list = List<Widget>()..add(buildAddButton());
  }


  @override
  Widget build(BuildContext context) {
    //得到屏幕的高度和宽度，用来设置Container的宽和高
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    


    return Scaffold(
      appBar: AppBar(
        title: Text('Wrap流式布局'),
      ),
      body:Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
            width: width,
            height: height/2,
            color: Colors.grey,
            child: Wrap(    //流式布局，
              children: list,
              spacing: 26.0,  //设置间距
            ),
          ),
        ),
      )
    );
  }

  Widget buildAddButton(){
    //返回一个手势Widget，只用用于显示事件
    return  GestureDetector(
      onTap:(){
        if(list.length<9){
          setState(() {
                list.insert(list.length-1,buildPhoto());
          });
        }
      },
      child: Padding(
        padding:const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.black54,
          child: Icon(Icons.add),
        ),
      ),
    );
  }


  Widget buildPhoto(){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.amber,
          child: Center(
            child: Text('照片'),
          ),
        ),
    );
  }

}
```

### 展开闭合实例-1

### ExpansionTile组件

`ExpansionTile Widget`就是一个可以展开闭合的组件，常用的属性有如下几个。

- title:闭合时显示的标题，这个部分经常使用`Text Widget`。
- leading:标题左侧图标，多是用来修饰，让界面显得美观。
- backgroundColor: 展开时的背景颜色，当然也是有过度动画的，效果非常好。
- children: 子元素，是一个数组，可以放入多个元素。
- trailing ： 右侧的箭头，你可以自行替换但是我觉的很少替换，因为谷歌已经表现的很完美了。
- initiallyExpanded: 初始状态是否展开，为true时，是展开，默认为false，是不展开

#### main.dart入口文件

```
import 'package:flutter/material.dart';
import 'expansion_tile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme: new ThemeData.dark(),
      home:ExpansionTileDemo()
    );
  }
}
```

expansion_tile.dart文件

```
import 'package:flutter/material.dart';

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('expansion tile demo')),
      body:Center(
        child: ExpansionTile(
          title:Text('Expansion Tile'),
          leading:Icon(Icons.ac_unit),
          backgroundColor: Colors.white12,
          children: <Widget>[
            ListTile(
              title:Text('list tile'),
              subtitle:Text('subtitle')
            )
          ],
          initiallyExpanded: true,
        )
      )
    );
  }
}
```

### 展开闭合实例-2

#### ExpansionPanelList 常用属性

- expansionCallback:点击和交互的回掉事件，有两个参数，第一个是触发动作的索引，第二个是布尔类型的触发值。
- children:列表的子元素，里边多是一个List数组。

#### ExpandStateBean 自定义类

为了方便管理制作了一个`ExpandStateBean`类，里边就是两个状态，一个是是否展开`isOpen`,另一个索引值。代码如下:

```
class ExpandStateBean{
  var isOpen;
  var index;
  ExpandStateBean(this.index,this.isOpen);
}
```

#### expansion_panel_list.dart

这个文件我就直接上代码了，讲解我会在视频里说明，代码中我也进行了详细的注释。

```
import 'package:flutter/material.dart';

class ExpansionPanelListDemo extends StatefulWidget {
  _ExpansionPanelListDemoState createState() => _ExpansionPanelListDemoState();
}

class _ExpansionPanelListDemoState extends State<ExpansionPanelListDemo> {
  var currentPanelIndex = -1;
  List<int> mList;   //组成一个int类型数组，用来控制索引
  List<ExpandStateBean> expandStateList;    //开展开的状态列表， ExpandStateBean是自定义的类
  //构造方法，调用这个类的时候自动执行
  _ExpansionPanelListDemoState(){
    mList = new List(); 
    expandStateList = new List();
    //便利为两个List进行赋值
    for(int i=0;i<10;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i,false));
    }
  }
   //修改展开与闭合的内部方法
  _setCurrentIndex(int index, isExpand){
    setState(() {
          //遍历可展开状态列表
          expandStateList.forEach((item){
            if(item.index==index){
              //取反，经典取反方法
              item.isOpen = !isExpand;
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("expansion panel list")
      ),
      //加入可滚动组件
      body:SingleChildScrollView(
        child: ExpansionPanelList(
          //交互回掉属性，里边是个匿名函数
          expansionCallback: (index,bol){
            //调用内部方法
            _setCurrentIndex(index, bol);
          },
          children: mList.map((index){//进行map操作，然后用toList再次组成List
            return ExpansionPanel(
              headerBuilder: (context,isExpanded){
                return ListTile(
                  title:Text('This is No. $index')
                );
              },
              body:ListTile(
                title:Text('expansion no.$index')
              ),
              isExpanded: expandStateList[index].isOpen
            );
          }).toList(),
        ),
      )

    );
  }
}
//自定义扩展状态类
class ExpandStateBean{
  var isOpen;
  var index;
  ExpandStateBean(this.index,this.isOpen);
}
```

### 绘制贝塞尔曲线

#### 去掉dubug图标

```
 debugShowCheckedModeBanner: false,
```

#### main.dart主文件

```
import 'package:flutter/material.dart';
import 'custom_clipper_two.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

```

ClipPath路径裁切控件

`clipPath`控件可以把其内部的子控件切割，它有两个主要属性（参数）:

- child :要切割的元素，可以是容器，图片.....
- clipper : 切割的路径，这个要和CustomClipper对象配合使用

```
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: <Widget>[
          ClipPath(
            clipper:BottomClipper(),
            child: Container(
              color:Colors.deepPurpleAccent,
              height: 200.0,
            ),
          )
        ],
      )
    );
  }
}
```

#### CustomClipper 裁切路径

```
class BottomClipperTest extends CustomClipper<Path>{
  @override
    Path getClip(Size size) {
      // TODO: implement getClip
      var path = Path();
      path.lineTo(0, 0);
      path.lineTo(0, size.height-30);
      var firstControlPoint =Offset(size.width/2,size.height);
      var firstEndPoint = Offset(size.width,size.height-30);

      path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

      path.lineTo(size.width, size.height-30);
      path.lineTo(size.width, 0);
    
      return path;

    }
    @override
      bool shouldReclip(CustomClipper<Path> oldClipper) {
        // TODO: implement shouldReclip
        return false;
      }

}
```

```
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              color: Colors.deepPurpleAccent,
              height: 200.0,
            ),
          )
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path  = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height-40);
    var firstControlPoint = Offset(size.width/4, size.height);
    var firstEndPoint = Offset(size.width/2.25, size.height-30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    var secondControlPoint = Offset(size.width/4*3, size.height-90);
    var secondEndPoint = Offset(size.width, size.height-40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height-40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

```

### 打开应用闪屏动画

### AnimationController

`AnimationController`是`Animation`的一个子类，它可以控制`Animation`, 也就是说它是来控制动画的，比如说控制动画的执行时间。

我们这里有了两个参数 ：

- `vsync:this` :垂直同步设置，使用this就可以了。
- `duration` : 动画持续时间，这个可以使用`seconds`秒，也可以使用`milliseconds`毫秒，工作中经常使用毫秒，因为秒还是太粗糙了。

来看一段代码，这段代码就是控制动画的一个典型应用。

```
 _controller = AnimationController(vsync:this,duration:Duration(milliseconds:3000));
_animation = Tween(begin: 0.0,end:1.0).animate(_controller);
```

#### animation.addStatusListener

`animation.addStatusListener`动画事件监听器，它可以监听到动画的执行状态，我们这里只监听动画是否结束，如果结束则执行页面跳转动作。

```
_animation.addStatusListener((status){
  if(status == AnimationStatus.completed){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context)=>MyHomePage()), 
      (route)=> route==null);
  }
});

```

- `AnimationStatus.completed`:表示动画已经执行完毕。
- `pushAndRemoveUntil`:跳转页面，并销毁当前控件

#### main.dart文件

```
import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home:SplashScreen()
    );
  }
}
```

#### splash_screen.dart文件

```
import 'package:flutter/material.dart';
import 'my_home_page.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    
	 /*动画事件监听器，
    它可以监听到动画的执行状态，
    我们这里只监听动画是否结束，
    如果结束则执行页面跳转动作。 */
    
    _animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyHomePage()), (route) => route == null);
      }
    });
    _controller.forward(); //播放动画
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Image.network(
        'http://img.mp.itc.cn/q_mini,c_zoom,w_640/upload/20170616/8205db47c40848d2a6b7fb0fb01f619b_th.jpg',
        scale: 2.0,
        fit: BoxFit.cover
      ),
    );
  }
}

```

#### home_page.dart文件

```
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('my home page'),),
      body: Center(
        child: Text('首页')
      ),
    );
  }
}

```

### 右滑返回上一页案例

#### Cupertino UI

其实早都知道Flutter有两套UI模板，一套是`material`,另一套就是`Cupertino`。`Cupertino`主要针对的的就是IOS系统的UI，所以用的右滑返回上一级就是在这个`Cupertino`里。

#### Cupertino的引入方法

直接使用import引入就可以了，代码如下:

```
import 'package:flutter/cupertino.dart';

```

引入了`cupertino`的包之后，就可以使用皮肤和交互效果的特性了。要用的右滑返回上一页也是皮肤的交互特性，直接使用就可以了。

#### CupertinoPageScaffold

这个和以前使用`material`的`Scaffold`类似，不过他里边的参数是`child`，例如下面的代码.

```
return CupertinoPageScaffold(
  child: Center(
    child: Container(
      height: 100.0,
      width:100.0,
      color: CupertinoColors.activeBlue,
      child: CupertinoButton(
        child: Icon(CupertinoIcons.add),
        onPressed: (){
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context){
              return RightBackDemo();
            })
          );
        },
      ),
    ),
  ),
);

```

在`Cupertino`下也有很多`Widget`控件，他们都是以`Cupertino`开头的，这就让我们很好区分，当然两种皮肤是可以进行混用的。

#### main.dart主文件

```
import 'package:flutter/material.dart';
import 'right_back_demo.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme:ThemeData(primarySwatch: Colors.blue),
      home: RightBackDemo(),
    );
  }
}

```

#### right_back_demo.dart

```
import 'package:flutter/cupertino.dart'; 

class RightBackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          height: 100.0,
          width:100.0,
          color: CupertinoColors.activeBlue,
          child: CupertinoButton(
            child: Icon(CupertinoIcons.add),
            onPressed: (){
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (BuildContext context){
                  return RightBackDemo();
                })
              );
            },
          ),
        ),
      ),
    );
  }
}
```

### ToolTip控件实例

#### 轻量级操作提示

其实Flutter中有很多提示控件,比如`Dialog`、`Snackbar`和`BottomSheet`这些操作都是比较重量级的，存在屏幕上的时间较长或者会直接打断用户的操作。

当然我并不是说这些控件不好，根据需求的不同，要有多种选择，所以才会给大家讲一下轻量级操作提示`Tooltip`

`Tooltip`是继承于`StatefulWidget`的一个Widget，它并不需要调出方法，当用户长按被`Tooltip`包裹的Widget时，会自动弹出相应的操作提示

#### main.dart文件

```
import 'package:flutter/material.dart';
import 'tool_tips_demo.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme:ThemeData.light(),
      home: ToolTipDemo(),
    );
  }
}
```

#### tool_tips_demo.dart文件

```
import 'package:flutter/material.dart';

class ToolTipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('tool tips demo')),
      body:Center(
        child: Tooltip(
          message: '不要碰我，我怕痒',
          child: Icon(Icons.all_inclusive),
        ),
      )
    );
  }
}

```

### Draggable控件实例

#### Draggable Widget

`Draggable`控件负责就是拖拽，父层使用了`Draggable`，它的子元素就是可以拖动的，子元素可以实容器，可以是图片。用起来非常的灵活。

参数说明：

- `data`: 是要传递的参数，在`DragTarget`里，会接受到这个参数。当然要在拖拽控件推拽到`DragTarget`的时候。
- `child`:在这里放置你要推拽的元素，可以是容器，也可以是图片和文字。
- `feedback`: 常用于设置推拽元素时的样子，在案例中当推拽的时候，我们把它的颜色透明度变成了50%。当然你还可以改变它的大小。
- `onDraggableCanceled`:是当松开时的相应事件，经常用来改变推拽时到达的位置，改变时用`setState`来进行。

```
Draggable(
  data:widget.widgetColor,
  child: Container(
    width: 100,
    height: 100,
    color:widget.widgetColor,
  ),
  feedback:Container(
    width: 100.0,
    height: 100.0,
    color: widget.widgetColor.withOpacity(0.5),
  ),
  onDraggableCanceled: (Velocity velocity, Offset offset){
    setState(() {
      this.offset = offset;
    });
  },
```

#### DragTarget Widget

`DragTarget`是用来接收拖拽事件的控件，当把`Draggable`放到`DragTarget`里时，他会接收`Draggable`传递过来的值，然后用生成器改变组件状态。

- onAccept:当推拽到控件里时触发，经常在这里得到传递过来的值。
- builder: 构造器，里边进行修改child值。

```
DragTarget(onAccept: (Color color) {
  _draggableColor = color;
}, builder: (context, candidateData, rejectedData) {
  return Container(
    width: 200.0,
    height: 200.0,
    color: _draggableColor,
  );
}),

```

#### main.dart入口文件

```
import 'package:flutter/material.dart';
import 'draggable_demo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Flutter Demo',
      theme:ThemeData(
        primarySwatch: Colors.blue
      ),
      home:DraggableDemo()
    );
  }
}
```

#### draggable_demo.dart 文件

```
import 'package:flutter/material.dart';

import 'draggable_widget.dart';

class DraggableDemo extends StatefulWidget {
  @override
  _DraggableDemoState createState() => _DraggableDemoState();
}

class _DraggableDemoState extends State<DraggableDemo> {
  Color _draggableColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        DraggableWidget(
          offset: Offset(80.0, 80.0),
          widgetColor: Colors.tealAccent,
        ),
        DraggableWidget(
          offset: Offset(180.0, 80.0),
          widgetColor: Colors.redAccent,
        ),
        Center(
          child: DragTarget(onAccept: (Color color) {
            _draggableColor = color;
          }, builder: (context, candidateData, rejectedData) {
            return Container(
              width: 200.0,
              height: 200.0,
              color: _draggableColor,
            );
          }),
        )
      ],
    ));
  }
}
```

#### draggable_widget.dart 文件

```
import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  final Offset offset;
  final Color widgetColor;
  const DraggableWidget({Key key, this.offset, this.widgetColor}):super(key:key);
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset offset = Offset(0.0,0.0);
  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
   return Positioned(
     left: offset.dx,
     top:offset.dy,
     child: Draggable(
       data:widget.widgetColor,
       child: Container(
         width: 100,
         height: 100,
         color:widget.widgetColor,
       ),
       feedback:Container(
         width: 100.0,
         height: 100.0,
         color: widget.widgetColor.withOpacity(0.5),
       ),
       onDraggableCanceled: (Velocity velocity, Offset offset){
         setState(() {
            this.offset = offset;
         });
       },
     ),
   );
  }
}
```
