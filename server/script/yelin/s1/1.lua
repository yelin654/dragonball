local mono
local guide
local talk
mono = am({"不得不辞去了上一份工作",
           "折腾了两三个地方后",
           "莫名其妙 也没有任何准备的",
           "来到了这家公司"})
function mono.on_start()
   play_bgm(2)
end

am({"直到遇见她",
    "我不迷信",
    "却相信命运..."})

ag({"Chapter.1"})

talk = at("XJ", "LJD是你老乡，长得还漂亮，好机会啊")
function talk.on_start()
   change_background(15)
end

at("我", "不是喜欢的类型...总穿裙子，妆还浓...")

at("我", "我倒一直觉得进门直对个儿那个小丫头不错，挺可爱...")

at("LY", "她啊，她叫XYZ，ZMM认识她")

at("我", "她不穿裙子，不穿高跟鞋，不化浓妆，还圆脸蛋...")

at("LY", "你这癖好还真是...")

mono = am({"在知道她的名字之后",
           "我还是没忍住去校内人肉了一下...",
           "翻了无数页 居然找到了...",
           "虽然没敢点进去",
           "但是时而的会去看看有没有更新头像..."})
function mono.on_start()
   clear_background()
end
ag({"一个多月后..."})

DEFAULT_TALK_THOUGH = "QQ"

talk = at("GY", "XYZ现在单身呦，考虑不")
function talk.on_start()
   change_background(3)
end

at("我", "兔子不食窝边草")

at("GY", "表手下留情啊，有需要就说，让ZMM给你介绍啊？她俩关系非常好")

ag({"请始终优先选择你想选择的，而不是我可能会选择的..."})
ag({"虽然它们不会带你进入另一个分支..."})

ac({"好啊", "不敢..."}, 2)

at("我", "找同事是大忌 等我换地方时再说吧~")

DEFAULT_TALK_THOUGH = ""

mono = am({"嘴上这么说 心里其实一直惦着呢",
           "每次路过门口都会偷偷看一眼",
           "中午吃饭时也盼着能在外头见到",
           "有时候她没来上班 会有点小郁闷",
           "她好像很喜欢低个小头走路",
           "我真是...越来越觉得可爱..."})
function mono.on_start()
   clear_background()
end

ag({"有天下午休息时路过门口 居然看到她在跟JX玩3ds"})

ac({"过去搭讪", "算了吧"}, 2)

at("我", "(还是不太敢 回去吧...)")

ag({"走到走廊停下了..."})

at("我", "(机会难得，错过可能就没了...还是过去看看吧)")

ag({"走到跟前 捅了一下JX"})

talk = at("我", "你们在连佣兵吗?")
function talk.on_start()
   change_background(6)
end

at("JX", "没呀")

at("XYZ", "佣兵...")

at("我", "噢...")

am({"离得太近了",
    "连看都没敢...",
    "脑袋一直面向JX",
    "不过...终于听到声音了！！！"})

ag({"然后就赶紧跑了..."})

chapter.pre = 0

