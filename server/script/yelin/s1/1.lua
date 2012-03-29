local mono = new_monolog()
mono.texts = {"不得不辞去了上一份工作",
              "折腾了两三个地方后",
              "莫名其妙 也没有任何准备的",
              "来到了这家公司"}

chapter.start = mono

local sound = new_sound(2)
function mono.on_start()
   play_bgm(sound)
end

mono.next = new_monolog()
mono = mono.next
mono.texts = {"直到遇见她...",
              "我不迷信",
              "却相信 这是命运..."}

local guide = new_guide()
guide.texts = {"Chapter.1"}

mono.next = guide

local talk = new_talk("CXJ", "LJD是你老乡，长得还漂亮，好机会啊")
guide.next = talk
local pic = new_pic(15)
function talk.on_start()
   change_background(pic)
end

talk.next = new_talk("我", "不是喜欢的类型...总穿裙子，妆还浓...")
talk = talk.next

talk.next = new_talk("我", "我倒一直觉得进门直对个儿那个小丫头不错，挺可爱...")
talk = talk.next

talk.next = new_talk("LY", "她啊，她叫XYZ，ZMM认识她")
talk = talk.next

talk.next = new_talk("我", "她不穿裙子，不穿高跟鞋，不化浓妆，还圆脸蛋...")
talk = talk.next

talk.next = new_talk("LY", "你这癖好还真是...")
talk = talk.next

mono = new_monolog()
mono.texts = {"在知道她的名字之后",
              "我还是没忍住去校内人肉了一下...",
              "翻了无数页 居然找到了...",
              "虽然没敢点进去",
              "但是时而的会去看看有没有更新头像..."}
talk.next = mono

guide = new_guide()
guide.texts = {"一个多月后..."}
mono.next = guide

DEFAULT_TALK_THOUGH = "QQ"

talk = new_talk("GY", "XYZ现在单身呦，考虑不")
guide.next = talk

talk.next = new_talk("我", "兔子不食窝边草")
talk = talk.next

talk.next = new_talk("GY", "表手下留情啊，有需要就说，可以让ZMM给你介绍，她俩关系非常好")
talk = talk.next

local choice = new_choice({"好啊", "不敢..."}, 2)
talk.next = choice

talk = new_talk("我", "找同事是大忌 等我换地方时再说吧~")
choice.next = talk

DEFAULT_TALK_THOUGH = ""

mono = new_monolog()
mono.texts = {"嘴上这么说 心里其实一直惦着呢",
             "每次路过门口都会偷偷看一眼",
             "中午吃饭时也盼着能在外头见到",
             "有时候她没来上班 会有点小郁闷",
             "经常会看她低个小头走路",
             "我真是...越来越觉得可爱..."}
talk.next = mono

guide = new_guide()
guide.texts = {"有天下午休息时路过门口，居然看到她在跟JX玩3DS"}
mono.next = guide

choice = new_choice({"过去搭讪", "算了吧..."}, 2)
guide.next = choice

talk = new_talk("我", "(还是不太敢 回去吧...)")
choice.next = talk

guide = new_guide()
guide.texts = {"走到走廊停下了..."}
talk.next = guide

talk = new_talk("我", "(机会难得，错过可能就没了...还是过去看看吧)")
guide.next = talk

guide = new_guide()
guide.texts = {"捅了一下JX"}
talk.next = guide

talk = new_talk("我", "你们在连佣兵吗?")
guide.next = talk

talk.next = new_talk("JX", "没呀")
talk = talk.next

talk.next = new_talk("XYZ", "佣兵...")
talk = talk.next

talk.next = new_talk("我", "噢...")
talk = talk.next

mono = new_monolog()
mono.texts = {"离得太近了",
              "连看都没敢...",
              "脑袋一直面向JX",
              "不过...终于听到声音了!!!"}
talk.next = mono

guide = new_guide()
guide.texts = {"然后就赶紧跑了..."}
mono.next = guide

chapter.pre = 0