---
layout: post
title: JSON Serialisation of Circular References
date: 2015-12-02 21:19:44.000000000 +10:30
type: post
published: true
categories: []
tags: []
author: Jim Burger
---
 Circular references make me cringe and shudder. Its not that they are bad per se, <em>its what we do with them that counts.</em>
 Now, the .NET garbage collector avoids memory issues with destroying circular references and we don't have to worry as much as <a href="https://msdn.microsoft.com/en-us/library/aa716190(v=vs.60).aspx">days of yore</a>, though I still can't help the shudder. I guess I'm getting old or something.
 When dealing with data over REST services in .NET it's hard to pass by the great JSON.NET library: Newtonsoft.Json which makes object serialisation of both typed and dynamic objects really simple.
 Knowing that circular references are somewhat of an inevitability, the library can handle these reference loops through serialisation configuration for you

```csharp
  //domain classes
  public class Parent
  {
    public string Name { get; }
    public List<Child> Children { get; } = new List<Child>();
    public Parent(string name)
    {
      Name = name;
    }
  }

  public class Child
  {
    public string Name { get; set; }
    public Parent Parent { get; set; }
  }

  //in an action, far far away...
  public IActionResult Get()
  {
    var vader = new Parent('Anakin');
    var luke = new Child() { Parent = vader, Name = 'Luke' };
    var leia = new Child() { Parent = vader, Name = 'Leia' };
     vader.Children.AddRange(new[] { luke, leia });
     return Json(luke);
  }
```
This code will throw an exception, as Newtonsoft rightly avoids a potential overflow during serialisation by <a href="https://en.wikipedia.org/wiki/Fail-fast">failing fast</a>.
<h3>Just ignore it and it will go away...</h3>
 By setting up Newtonsoft.Json to ignore these 'reference loops' it will avoid the exception and life can apparently move on.

 ```csharp
.
.
.
var settings = new JsonSerializerSettings()
{
  ReferenceLoopHandling = ReferenceLoopHandling.Ignore
}
return Json(luke, settings);
```
### Its all relative
 So while the above piece of code appears to be innocent enough, it harbours a runtime issue for the trusting developer.
 <img class="alignnone size-full wp-image-827701" src="{{ site.baseurl }}/assets/australia-head-in-sand-climate-change1.jpg" alt="australia-head-in-sand-climate-change" width="742" height="404" /> **The further you stick your head in the sand, the more exposed your butt becomes.**

 How is this library ignoring reference loops? Turns out, if we execute the above snippet we end up with the following JSON:

 ```javascript
{
  'Name':'Luke',
  'Parent':{
    'Name':'Anakin',
    'Children':[
      {'Name':'Leia'}
      /*... I find your lack of objects, disturbing ... */
    ]
  }
}
```

 If we're leaning on the above to retrieve a parent's children from a child reference - we'd in trouble, as the serialiser will have ignored 'luke' the second time it encounters it. You just shouldn't do it. The documentation is pretty clear:
 "Json.NET will ignore objects in reference loops and not serialise them. The first time an object is encountered it will be serialised as usual but if the object is encountered as a child object of itself the serialiser will skip serialising it."
 If you were particularly keen to teach the serialiser new tricks, you can of course go ahead and <a href="http://www.newtonsoft.com/json/help/html/ConditionalProperties.htm">derive your own IContractResolver</a>.
<h3>If latency is King, then order of complexity is Queen.</h3>
 This also brings up the question of performance: if it is actively tracking and matching each new object, surely this is slow? What if we avoided circular references?

```csharp
//domain classes
public class Parent
{
  public string Name { get; }
  public List&lt;string&gt; Children { get; } = new List&lt;string&gt;();
  public Parent(string name)
  {
    Name = name;
  }
}
 public class Child
{
  public string Name { get; set; }
  public Parent Parent { get; set; }
}
 var parent = new Parent('Padme');
parent.Children.Add(luke.Name, leia.Name);
```

 Turns out of we avoid the circular reference by leaning on some kind of natural key, we can decrease processing time by a lot:
<h2><img class="alignnone size-full wp-image-827709" src="{{ site.baseurl }}/assets/capture.png" alt="Capture" width="1267" height="699" /></h2>
 I'm no expert on #perfmatters, but my rudimentary test loads up a parent object with several million children and then checks the time taken to serialize that parent, using similar approaches to what you've read above. It would seem that avoiding circular references prior to serialization <strong><em>has some impact.</em></strong>
<h3>TL;DR</h3>
 When serialising domain models with circular references, care must be taken to respect that serialisers can't magic away all the problems for you and you'll need to be aware of the downstream implications for your API, both from a correctness standpoint, and a performance one.
