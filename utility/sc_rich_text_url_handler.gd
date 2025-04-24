extends RichTextLabel
class_name ScRichTextUrlHandler
## [RichTextLabel] の BB Code を有効にして、 [code][lb]url=https://xxx[rb]title[lb]/url[rb][/code] と書いたリンクを
## クリックした際に、開く処理を実装したスクリプトです。[br]
## 例：[url=https://compota-soft.work/]Compota-Soft-Press[/url][br]
## リンクを記述した RichTextLabel にこのスクリプトを割り当てることで URL タグのリンクをクリックした際に開けるようになります。[br]

# Called when the node enters the scene tree for the first time.
func _ready():
	# meta_clicked シグナルに任意の関数を設定します。
	# 指定した関数は、 BB Code の URL タグのリンクをクリックした際に、
	# その URL 文字列を引数にして呼び出されます。
	meta_clicked.connect(_richtextlabel_on_meta_clicked)
	return

## クリックされた BB Code のリンク先を開きます。
## BB Code の URL タグのリンクをクリックした際に、その URL 文字列を引数にして呼び出されます。
## This assumes RichTextLabel's `meta_clicked` signal was connected to
## the function below using the signal connection dialog.
## https://docs.godotengine.org/en/stable/classes/class_richtextlabel.html#class-richtextlabel-signal-meta-clicked
func _richtextlabel_on_meta_clicked(meta):
	OS.shell_open(str(meta))
	return
