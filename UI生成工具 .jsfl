fl.outputPanel.clear();
var myUrl="file:///D:/yingxiong/src/game/view/viewBase/";
var doc = fl.getDocumentDOM();
var lib = doc.library;
var tmp_list = lib.items;
var len = tmp_list.length;
var gap = 4;
var hasList = false;
var hasTabMenu = false;
var hasTabButton = false;
var hasInput = false;
var hasScale9 = false;
var END=";\n";
var publicVar;
var functionStr;
var importStr;
var curr_class;
if(!FLfile.exists(myUrl))
{
	//FLfile.createFolder(myUrl);
	alert("保存目录不存在，请先配置目录！");
	len=0;
}
for (var i = 0; i < len;++i)
{
	item = tmp_list[i]

	if (!item.linkageClassName)
	{
		continue;
	}
	if(!item.linkageBaseClass)
	{
		trace(item.name+"没有导出继承基类");
		continue;
	}
	parseView(item);
}

function parseView(item)
{
	hasList = false;
	hasTabMenu = false;
	hasScale9 = false;
	hasTabButton = false;
	hasInput = false;
	var code = "";
	publicVar="";
	importStr="";
	functionStr  = getPaddingLeftSpace(gap * 2) + "public function get assetMgr():AssetManager{return AssetMgr.instance;}\n";
	//解析名字
	var save_url = item.name;
	if(save_url.indexOf("/")>=0)
		save_url=save_url.split("/").pop();
	if(save_url.indexOf("Base")==-1)
		save_url+="Base";
	if(save_url.indexOf(".">=0))
		save_url=save_url.split(".").pop();
	curr_class=save_url;
	
	var tmp_code=forElement(item.timeline,"");
	code+=getClassHear(save_url,tmp_code,item.linkageBaseClass);
	save_url=myUrl+save_url+".as";
	
	//文件不存在则创建文件
	if(!FLfile.exists(save_url))
		FLfile.write(save_url, "")
	if (!FLfile.write(save_url, code))
		alert("文件保存失败！");
	else
		trace("成功生成!"+save_url)
}


//获得类的头文件
function getClassHear(name,code_content,extendsClass)
{
	code="";
	tmp_arr= name.split(".");
	className=tmp_arr.pop();
	packName=tmp_arr.join(".");
	code += "package " +packName +" game.view.viewBase\n";
	code += "{\n";
	space=getPaddingLeftSpace(gap);
	code += space + "import starling.display.Image" + END;
	code += space + "import game.manager.AssetMgr" + END;
	code += space + "import starling.utils.AssetManager" + END;
	code += space + "import starling.display.Sprite" + END;
	code += space + "import starling.textures.Texture" + END;
	code += space + "import starling.text.TextField" + END;
	code += space + "import starling.display.Button" + END;
	code += space + "import flash.geom.Rectangle" + END;
	code += space + "import com.utils.Constants" + END;
	code += space + "import feathers.controls.TextInput" + END;
	if (hasTabMenu)
		code += space + "import com.components.TabMenu" + END;
	if (hasTabButton)
		code += space + "import com.components.TabButton" + END;

	if (hasList)
		code += space + "import feathers.controls.List" + END;

	if (hasTabMenu)
		code += space + "import com.components.TabMenu" + END;
		
	if (hasScale9)
	{
		code += space + "import feathers.display.Scale9Image" + END;
		code += space + "import feathers.textures.Scale9Textures" + END;


		code += space + "import com.components.Scale9Button" + END;
	}
	
	if(hasInput)
	{
		code += space + "import feathers.controls.TextInput" + END;
	}
	if(importStr)
		code+=importStr;
	if(code.indexOf(extendsClass)==-1)
		code += space +"import "+ extendsClass + END;
		
	extendsClass=extendsClass.split(".").pop();
	
	code +="\n";
	//类
	code += space+ "public class "+ className+  " extends " +extendsClass+ "\n";
	code += space+ "{\n";
	if(publicVar)
		code += publicVar;
	code +="\n";
	space=getPaddingLeftSpace(gap*2);
	//构造函数
	code+= space+ "public function "+className +"()\n";
	code+= space+"{\n";
	var isSuperView=extendsClass=="View" || extendsClass=="Dialog" ||extendsClass=="TabDialog" || extendsClass=="EquipViewBase" || extendsClass=="BaseScene";
	if(isSuperView)
		code+= getPaddingLeftSpace(gap*3)+"super(false);\n";
	//临时变量
	code+= getTmpVariable();
	//代码
	code+= code_content;
	if(isSuperView)
		code+= getPaddingLeftSpace(gap*3)+"init();\n";
	code+= space+"}\n";
	//函数
	code+= functionStr;
	space=getPaddingLeftSpace(gap);
	code+= space+"}\n";
	code+= "}\n";
	return code;
}

//定义临时变量
function getTmpVariable()
{
	code = "";
	code += addImportClass("texture:Texture");
	code += addImportClass("textField:TextField");
	code += addImportClass("input_txt:TextInput");
	code += addImportClass("image:Image");
	code += addImportClass("button:Button");

	return code;
}

function forElement(time_line,parentName)
{
	var layerCount = time_line.layerCount;
	var code="";
	//重最底层开始转换
	for (var layer_index = layerCount - 1; layer_index >= 0; layer_index--)
	{
		var layer = time_line.layers[layer_index];

		if (!layer.visible)
			continue;
		//只处理元件第一帧
		var frame = layer.frames[0];
		var elements_length = frame.elements.length;

		for (var element_index = 0; element_index < elements_length; element_index++)
		{
			element = frame.elements[element_index];
			code += parseElement(element, parentName);
		}
	}
	return code;
}

function parseElement(element, parentName)
{
	code = "";
	libraryItem = element.libraryItem;

	if (libraryItem == null)
	{
		switch (element.elementType)
		{
			case 'text':
				type = element.textType;

				if (type == "input")
					code = parseInputText(element,parentName);
				else
					code = parseText(element, parentName);
				break;
		}
	}
	else
	{
		switch (libraryItem.itemType)
		{
			case 'bitmap':
				code = parseBitmap(element, parentName);
				break;
			case 'movie clip':
				if (element.libraryItem.linkageBaseClass)
				{
					code = parseClass(element, parentName);
				}
				else if (element.name.indexOf("tabMenu") == 0)
				{
					code = parseTabMenu(element, parentName);
				}
				else if (element.name.indexOf("list_") == 0)
				{
					code = parseList(element, parentName);
				}
				else if (element.name.indexOf("tab_") == 0)
				{
					code = parseTabButton(element, parentName);
				}
				else if (libraryItem.scalingGrid)
				{
					if(element.name.indexOf("Scale9Button") != -1)
					{
							
							code = parse9ScaleButton(element, parentName);
					}
					else
					{
						code = parse9Scale(element, parentName);
					}
					
				}
				else
				{
					code = parseMovieClip(element, parentName);
				}
				break;
			case 'button':
				code = parseButton(element, parentName);
				break;
		}
	}

	return code;
}

/* 分析位图
   显示对象定义，以库中的资源名命名且定义为全局公共属性
   为了绝决重用资源问题，显示对象定义添加了该对象的位置为后缀
 */
function parseBitmap(element, parentName)
{
	var content = "";
	var path = element.libraryItem.sourceFilePath;
	var name = element.libraryItem.name;

	//path = path.slice(path.lastIndexOf("/")+1,path.indexOf("."));

	if (name.lastIndexOf(".") != -1)
	{
		name = name.slice(0, name.lastIndexOf("."));
	}
	path = name;
	name = filter(name);
	name += Math.round(Math.abs(element.x)) + "" + Math.round(Math.abs(element.y));
	var imageName = "image";
	content += getPaddingLeftSpace(gap * 3) + "texture" + " =" + getTexture(path)+";\n";
	content += getPaddingLeftSpace(gap * 3) + imageName + " = new Image(texture);\n";

	content += fullXYAttirbute(element, imageName);
	content += fullWHAttirbute(element, imageName);
	content += fullRotationAttirbute(element, imageName);

	if(element.layer.name=="背景")
		content +=addField(imageName ,"smoothing","Constants.NONE");
	else
	{
		content += touchable(element, imageName);
		content += addField(imageName ,"smoothing","Constants.smoothing");
	}
	
	content += addChild(imageName, parentName);

	return content;
}

function touchable(element, name)
{
	return getPaddingLeftSpace(gap * 3) + name + ".touchable = false;\n";

}

/* 分析显示文本 */
function parseText(element, parentName)
{
	var name = element.name

	if (!name)
		alert(curr_class+"显示文本未命名！"+parentName);
	var size = element.getTextAttr("size");
	var bold = element.getTextAttr("bold");
	var color = element.getTextAttr("fillColor").replace("#", "0x");
	var face = element.getTextAttr("face");
	var type = element.textType;
	var alignment = element.getTextAttr("alignment");

	var content = "";
	var w = Math.round(element.width);
	var h = Math.round(element.height);
	face = "''";

	if (!parentName)
	{
		addDefine(name, "TextField");
		content += createObject(name, "TextField", w + "," + h + "," + "''" + "," + face + "," + size + "," + color + "," + bold);
		content += touchable(element, name);
		content +=addField(name ,"hAlign",addStr(alignment));
		content +=addField(name ,"text",addStr(element.getTextString()));
		content += fullXYAttirbute(element, name);
		content += addChild(name, parentName);
	}
	else if (element.name == "label")
	{
		content += getPaddingLeftSpace(gap * 3) + parentName + ".textBounds = new Rectangle(" + Math.round(element.x) + "," + Math.round(element.y) + "," + w + "," + h + ");\n";
		content +=addField(parentName ,"fontSize",size);
		content +=addField(parentName ,"fontColor",color);
		content +=addField(parentName ,"fontBold",bold);
	}
	else if (parentName)
	{
		name = "textField";
		content += createObject(name, "TextField", w + "," + h + "," + "''" + "," + face + "," + size + "," + color + "," + bold);
		content += touchable(element, name);
		content += fullXYAttirbute(element, name);
		content +=addField(name ,"hAlign",addStr(alignment));
		content +=addField(name ,"text",addStr(element.getTextString()));
		content +=addField(name ,"name",addStr(element.name));
		content += addChild(name, parentName);
	}

	return content;
}

/* 分析输入文本 
*/
function parseInputText(element, parentName)
{
	hasInput=true;
	var name = element.name
	if(!name)
	{
		alert("输入文本未命名！");
	}
	
	var size = element.getTextAttr("size");
	var bold = element.getTextAttr("bold");
	var color = element.getTextAttr("fillColor");
	color = color.replace("#","0x");
	var type = element.textType;
	var alignment = element.getTextAttr("alignment");
	var content = "";

	if (parentName)
	{
		name="input_txt";
		content = getPaddingLeftSpace(gap*3) + name +" = new TextInput();\n";
		content +=addField(name ,"name",addStr(element.name));
	}
	else
	{
		addDefine(name,"TextInput");
		content = getPaddingLeftSpace(gap*3) + name +" = new TextInput();\n";
		var addFun = getPaddingLeftSpace(gap*3) + name + ".dispose();\n";
		addFunction("dispose",true,addFun);
	}
	
	content += getPaddingLeftSpace(gap*3) + name + ".textEditorProperties.fontSize = " +  size+";\n"
	content += getPaddingLeftSpace(gap*3) + name + ".text = '" +  element.getTextString()+"';\n";
	content += getPaddingLeftSpace(gap*3) + name + ".textEditorProperties.color = " +  color+";\n";
	content += fullXYAttirbute(element, name);
	content += fullWHAttirbute(element, name);
	content += addChild(name, parentName);

	
	return content;
}

/* 分析影片剪辑
 */
function parseMovieClip(element, parentName)
{
	var content = "";
	var name = filter(element.libraryItem.name);

	if (name.lastIndexOf(".") != -1)
		name = name.slice(0, name.lastIndexOf("."));

	if (name.indexOf("view_") >= 0)
	{
		addDefine(element.name, "Sprite");
		content += createObject(element.name, "Sprite", "");
		content += fullXYAttirbute(element, element.name);
		content += fullWHAttirbute(element, element.name);
		content += addChild(element.name, parentName);
		content += addField(element.name ,"name",addStr(element.name));
		content += forElement(element.libraryItem.timeline, element.name);
		var addFun = getPaddingLeftSpace(gap * 3) + element.name + ".dispose();\n";
		addFunction("dispose", true, addFun);
		return content;
	}

	var path = element.libraryItem.timeline.layers[0].frames[0].elements[0].libraryItem.name;
	name = filter(element.name);
	if (!name)
		alert(curr_class+"影片剪辑未命名！");

	var imageName = name;
	content += getPaddingLeftSpace(gap * 3) + "texture" + " = " + getTexture(path)+"\n";

	if (parentName)
	{
		imageName="image";
		content += createObject(imageName, "Image", "texture");
		content +=addField(imageName ,"name",addStr(element.name));
	}
	else
	{
		content += createObject(imageName, "Image", "texture");
		addDefine(imageName, "Image");
	}

	content += fullXYAttirbute(element, imageName);
	content += fullWHAttirbute(element, imageName);
	content += fullScaleAttirbute(element, imageName);
	content += addChild(imageName, parentName);
	content += touchable(element, imageName);
	return content;
}

function parseList(element, parentName)
{
	hasList = true;
	var content = "";
	var libraryItem = element.libraryItem;
	var buttonName = element.name;
	if (!buttonName)
		alert(curr_class+"显示list未命名！");
	var layer = libraryItem.timeline.layers;
	addDefine(buttonName, "List");
	content += createObject(buttonName, "List", "");
	content += fullXYAttirbute(element, buttonName);
	content += fullWHAttirbute(element, buttonName);
	content += addChild(buttonName, parentName);
	var addFun = getPaddingLeftSpace(gap * 3) + buttonName + ".dispose();\n";
	addFunction("dispose", true, addFun);
	return content;
}

function parseClass(element, parentName)
{
	var content = "";
	var libraryItem = element.libraryItem;
	var name = element.name;
	
	var resClass = libraryItem.name;
	if(resClass.indexOf("/")>=0)
		resClass=resClass.split("/")[1];
	if(importStr.indexOf(resClass)==-1)
		importStr += getPaddingLeftSpace(gap) + "import " + resClass + END;
	resClass=resClass.split(".").pop();
	addDefine(name, resClass);
	content += createObject(name, resClass, "");
	content += fullXYAttirbute(element, name);
	content += addChild(name, parentName);
	var addFun = getPaddingLeftSpace(gap * 3) + name + ".dispose();\n";
	addFunction("dispose", true, addFun);
	return content;
}


function parseTabMenu(element, parentName)
{
	hasTabMenu = true;
	var content = "";
	var names = element.name.split("$");
	var buttonName = names.shift();
	addDefine(buttonName, "TabMenu");
	content += createObject(buttonName, "TabMenu", "[" + names.join(",") + "]");
	content += fullXYAttirbute(element, buttonName);
	content += addChild(buttonName, parentName);
	var addFun = getPaddingLeftSpace(gap * 3) + buttonName + ".dispose();\n";
	addFunction("dispose", true, addFun);
	return content;
}

function parseTabButton(element, parentName)
{
	hasTabButton = true;
	var content = "";
	var libraryItem = element.libraryItem;
	var buttonName = element.name;
	var layer = libraryItem.timeline.layers;
	var param = "";
	
	var tab2_name = layer[1].frames[0].elements[0].libraryItem.name;
	var tab1_name = layer[1].frames[1]?layer[1].frames[1].elements[0].libraryItem.name:tab1_name;
	
	addDefine(buttonName, "TabButton");
	content += createObject(buttonName, "TabButton", getTexture(tab1_name) + "," + getTexture(tab2_name));
	content += fullXYAttirbute(element, buttonName);
	content += fullWHAttirbute(element, buttonName);
	content += addChild(buttonName, parentName);
	var text = layer[0].frames[0].elements[0];
	
	if (text)
	{
		var size = text.getTextAttr("size");
		var color = text.getTextAttr("fillColor");
		color = color.replace("#", "0x");
		var alignment = text.getTextAttr("alignment");
		content +=addField(buttonName ,"text",addStr(text.getTextString()));
		content +=addField(buttonName ,"fontColor",color);
		content +=addField(buttonName ,"fontSize",size);
	}
	
	var addFun = getPaddingLeftSpace(gap * 3) + buttonName + ".dispose();\n";
	addFunction("dispose", true, addFun);
	return content;
}

/* 分析按钮 */
function parseButton(element, parentName)
{
	var content = "";
	var libraryItem = element.libraryItem;
	var name = element.name;

	path = libraryItem.timeline.layers[0].frames[0].elements[0].libraryItem.name;
	
	if (!name)
		alert(curr_class+"按钮未命名!");
	
	name = filter(name);
	var buttonName;
	var textureName = "texture";
	content += getPaddingLeftSpace(gap * 3) + textureName + " = " + getTexture(path) +END;
	if (parentName)
	{
		buttonName = "button";
		content += createObject(buttonName,"Button", textureName);
		content += addField(buttonName ,"name",addStr(element.name));
	}
	else
	{
		buttonName = name;
		addDefine(buttonName, "Button");
		content += createObject(buttonName,"Button", textureName);
		content += addField(buttonName ,"name",addStr(element.name));
		var addFun = getPaddingLeftSpace(gap * 3) + buttonName + ".dispose();\n";
		addFunction("dispose", true, addFun);
	}
	content += fullXYAttirbute(element, buttonName);
	content += fullWHAttirbute(element, buttonName);
	content += addChild(buttonName, parentName);
	
	var text;
	
	if (libraryItem.timeline.layers[0].frames[0].elements.length == 2)
		text = libraryItem.timeline.layers[0].frames[0].elements[1];
	
	//添加文本
	if (text && text.elementType == "text")
	{
		if (text.getTextString())
		{
			size = text.getTextAttr("size");
			color = text.getTextAttr("fillColor");
			color = color.replace("#", "0x");
			alignment = text.getTextAttr("alignment");
			content +=addField(buttonName ,"text",addStr(text.getTextString()));
			content +=addField(buttonName ,"fontColor",color);
			content +=addField(buttonName ,"fontSize",size);
		}
	}
	else if (libraryItem.timeline.layers[0].frames[0].elements.length > 1)
	{
		content += forElement(element.libraryItem.timeline, element.name);
	}
	
	return content;
}


/* 分析九宫格
   
 */
function parse9Scale(element, parentName)
{
	hasScale9=true;
	var content = "";
	var libraryItem = element.libraryItem;
	var name=libraryItem.name;
	
	if (name.lastIndexOf(".") != -1)
	{
		name = name.slice(0, name.lastIndexOf("."));
	}
	path = name;
	name += Math.round(Math.abs(element.x)) + "" + Math.round(Math.abs(element.y));

	if (element.name)
	{
		name = element.name;
	}
	name = filter(name);
	var buttonMC = name;

	var textureName = "texture";
	var rect = name + "Rect";
	var texture9Scale = name + "9ScaleTexture";

	var grid = getScalintGrid(element);

	content += getPaddingLeftSpace(gap * 3) + textureName + " = " + getTexture(path)+END;
	content += getPaddingLeftSpace(gap * 3) + "var " + rect + ":Rectangle = new Rectangle(" + grid.x + "," + grid.y + "," + grid.width + "," + grid.height + ");\n";
	content += getPaddingLeftSpace(gap * 3) + "var " + texture9Scale + ":Scale9Textures = new Scale9Textures(" + textureName + "," + rect + ");\n";

	if (parentName)
	{
		content += createObject("var "+ buttonMC+" : Scale9Image","Scale9Image", texture9Scale);
	}
	else
	{
		addDefine(buttonMC, "Scale9Image");
		content += createObject(buttonMC,"Scale9Image", texture9Scale);
	}

	content += fullXYAttirbute(element, buttonMC);
	content += fullWHAttirbute(element, buttonMC);
	content += addChild(buttonMC, parentName);
	return content;
}


/* 
九宫格按钮
   如果该影片剪辑为启用九宫格，则本程序自动启用
 */
function parse9ScaleButton(element, parentName)
{
	hasScale9=true;
	var content = "";
	var libraryItem = element.libraryItem;
	var name=libraryItem.name;
	
	if (name.lastIndexOf(".") != -1)
	{
		name = name.slice(0, name.lastIndexOf("."));
	}
	path = name;
	name += Math.round(Math.abs(element.x)) + "" + Math.round(Math.abs(element.y));

	if (element.name)
	{
		name = element.name;
	}
	name = filter(name);
	var buttonMC = name;

	var textureName = "texture";
	var rect = name + "Rect";
	var texture9Scale = name + "9ScaleTexture";

	var grid = getScalintGrid(element);

	content += getPaddingLeftSpace(gap * 3) + textureName + " = " + getTexture(path)+END;
	content += getPaddingLeftSpace(gap * 3) + "var " + rect + ":Rectangle = new Rectangle(" + grid.x + "," + grid.y + "," + grid.width + "," + grid.height + ");\n";
	//content += getPaddingLeftSpace(gap * 3) + "var " + texture9Scale + ":Scale9Textures = new Scale9Textures(" + textureName + "," + rect + ");\n";


	if (parentName)
	{
		content += createObject("var "+ buttonMC+" : Scale9Button","Scale9Button", textureName +"," + rect);
	}
	else
	{
		addDefine(buttonMC, "Scale9Button");
		content += createObject(buttonMC,"Scale9Button", textureName +"," + rect);
	}

	content += fullXYAttirbute(element, buttonMC);
	content += fullWHAttirbute(element, buttonMC);
	content += addChild(buttonMC, parentName);

	content += getPaddingLeftSpace(gap * 3) + buttonMC + ".name = '" + buttonMC +"'"+ END;

	var text;
	
	if (libraryItem.timeline.layers[0].frames[0].elements.length == 2)
		text = libraryItem.timeline.layers[0].frames[0].elements[1];
	
	//添加文本
	if (text && text.elementType == "text")
	{
		if (text.getTextString())
		{
			size = text.getTextAttr("size");
			color = text.getTextAttr("fillColor");
			color = color.replace("#", "0x");
			alignment = text.getTextAttr("alignment");
			content +=addField(name ,"text",addStr(text.getTextString()));
			content +=addField(name ,"fontColor",color);
			content +=addField(name ,"fontSize",size);
		}
	}
	else if (libraryItem.timeline.layers[0].frames[0].elements.length > 1)
	{
		content += forElement(element.libraryItem.timeline, element.name);
	}
	
	return content;
}

/* 启用九宫格 */
function getScalintGrid(element)
{
	var libraryItem = element.libraryItem;

	if (!libraryItem.scalingGrid)
	{
		//if (confirm("元件" +libraryItem.name + "未启用九宫格，是否启用？")) {
		libraryItem.scalingGrid = true;
			//}
	}
	var grid = libraryItem.scalingGridRect;
	var x = Math.round(grid.left);
	var y = Math.round(grid.top);
	var w = Math.round(grid.right - grid.left);
	var h = Math.round(grid.bottom - grid.top);
	grid = {x: x, y: y, width: w, height: h};
	return grid;
}

function getTexture(name)
{
	if (name.indexOf(".") >= 0)
		name = name.split(".")[0];
	return "assetMgr.getTexture('" + name + "')";
}

function createObject(name, className, param)
{
	return getPaddingLeftSpace(gap * 3) + name + " = new " + className + "(" + param + ");\n";
}

function addField(name,field,value)
{
	return getPaddingLeftSpace(gap * 3) + name + "."+field+ "= "+ value + END;
}

function addImportClass(str)
{
	return getPaddingLeftSpace(gap * 3) + "var "+  str + END;
}

/**
 * 获得左边距的空格
 *
 */
function getPaddingLeftSpace(gap)
{
	str = "";

	for (var i = 0; i < gap; i++)
		str += " ";
	return str;
}

/* 添加到舞台 */
function addChild(name, target)
{
	return getPaddingLeftSpace(gap * 3) + (target ? target : "this") + ".addQuiackChild(" + name + ");\n";
}

/** 填充宽高属性 */
function fullWHAttirbute(element, name)
{
	var content = "";
	var w = Math.round(element.width);
	var h = Math.round(element.height);
	content += getPaddingLeftSpace(gap * 3) + name + ".width = " + w + ";\n";
	content += getPaddingLeftSpace(gap * 3) + name + ".height = " + h + ";\n";

	return content;
}

/** 填充位置属性 */
function fullXYAttirbute(element, name)
{
	var content = "";
	var x = Math.round(element.x);
	var y = Math.round(element.y);
	if(x!=0)
	content += getPaddingLeftSpace(gap * 3) + name + ".x = " + x + ";\n";
	if(y!=0)
	content += getPaddingLeftSpace(gap * 3) + name + ".y = " + y + ";\n";
	return content;
}

/**
 * 添加公共变量定义
 *
 */
function addDefine(id, className)
{
	publicVar+= getPaddingLeftSpace(gap * 2) + "public var " + id + ":" + className + END;
}

function trace(str)
{
	fl.trace(str);
}

function filter(name)
{
	name = name.replace("@", "");
	name = name.replace("/", "");
	name = name.replace("-", "");
	name = name.replace(".", "");
	name = name.replace(END, "");
	name = name.replace("\t", "");
	name = name.replace("\f", "");
	name = name.replace("\r", "");
	name = name.replace(" ", "");
	return name;
}

function fullRotationAttirbute(element, name)
{
	var content = "";

	if (element.rotation == 90)
		content += getPaddingLeftSpace(gap * 3) + name + "." + "rotation = " + (90 * (Math.PI / 180)) + ";" + END;
	else if (element.rotation == -90)
		content += getPaddingLeftSpace(gap * 3) + name + "." + "rotation = " + (-90 * (Math.PI / 180)) + ";" + END;
	else
	{
		if (element.matrix.a < 0)
			content += getPaddingLeftSpace(gap * 3) + name + "." + "scaleX = " + element.matrix.a + END;

		if (element.matrix.d < 0)
			content += getPaddingLeftSpace(gap * 3) + name + "." + "scaleY = " + element.matrix.d + END;
	}
	return content;
}

function fullScaleAttirbute(element, name)
{
	var content = "";
	if (element.matrix.a < 0)
		content += getPaddingLeftSpace(gap * 3) + name + "." + "scaleX = " + element.matrix.a + ";" + "\n";

	if (element.matrix.d < 0)
		content += getPaddingLeftSpace(gap * 3) + name + "." + "scaleY = " + element.matrix.d + ";" + "\n";
	return content;
}

function addStr(str)
{
	return "'"+str+"'";
}

/* name - 方法名 over - 是否为重写父类方法 content-方法内容
   如果该方法或方法内容语句已存在则跳过该语句
 */
function addFunction(name, over, content)
{
	var str = "";

	if (functionStr.indexOf("function " + name) != -1)
	{
		functionStr = functionStr.slice(0, functionStr.length - 11);

		var arr = content.split(END);
		var len = arr.length;

		for (var i = 0; i < len; i++)
		{
			var sub = arr[i];

			if (functionStr.indexOf(sub) == -1)
			{
				str += sub + END;
			}
		}
	}
	else
	{
		str = getPaddingLeftSpace(gap * 2);

		if (over)
			str += "override ";
		str += "public function " + name + "():void\n";
		str += str = getPaddingLeftSpace(gap * 2) + "{\n";
		str += content;
	}

	if (name == "dispose")
	{
		functionStr = functionStr.replace(getPaddingLeftSpace(gap * 3) + "super.dispose();\n", "");
		str += getPaddingLeftSpace(gap * 3) + "super.dispose();\n";
	}

	str += getPaddingLeftSpace(gap * 2) + "\n}\n";
	functionStr += str;
}