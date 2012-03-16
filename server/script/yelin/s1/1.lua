local mono = new_monolog()
mono.texts = {"不得不辞去了上一份工作",
              "折腾了两三个地方后",
              "莫名其妙，也没有任何准备的",
              "来到了这家公司"}

chapter.start = mono

local sound = new_sound()
sound.rid = 2
function mono.on_start()
   stop_all_sound()
   play_sound(sound)
end

mono.next = new_monolog()
mono = mono.next
mono.texts = {"然后",
               "遇见了她...",
               "我不迷信",
               "却相信命运.."}

local guide = new_guide()
guide.texts = {"Chapter.1"}

mono.next = guide

local talk = new_talk("LJD是你老乡，长得还漂亮，好机啊", "CXJ")
guide.next = talk

talk.next = new_talk("不是喜欢的类型...总穿裙子，妆还浓...", "我")
talk = talk.next

talk.next = new_talk("我倒一直觉得进门直对个儿那个小丫头不错，挺可爱...", "我")
talk = talk.next

talk.next = new_talk("她啊，她叫XYZ，ZMM认识她", "LY")
talk = talk.next

talk.next = new_talk("她不穿裙子，不穿高跟鞋，不化浓妆，还圆脸蛋...", "我")
talk = talk.next

talk.next = new_talk("你这癖好还真是...", "LY")
talk = talk.next

mono = new_monolog()
mono.texts = {"在知道她的名字之后",
              "我还是没忍住去校内人肉了一下...",
              "翻了无数页， 居然找到了...",
              "虽然没敢点进去，但是时而的会去看看有没有更新头像..."}
talk.next = mono

guide = new_guide()
guide.texts = {"一个多月后..."}

mono.next = guide

chapter.pre = 0