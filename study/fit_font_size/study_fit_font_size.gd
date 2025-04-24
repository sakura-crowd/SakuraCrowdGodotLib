extends Control

## コントロール（例では Button）のサイズからはみでない最大のフォントサイズを設定するテスト用のシーンです。

# Called when the node enters the scene tree for the first time.
func _ready():
	# Button ノードのフォントサイズを調整します。
	fit_font_size($Button, $Button.text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

## [param control] のサイズにフィットするように、 [param text] を描画できる最適なフォントサイズを設定します。
## フォントサイズは、 [param control] の Theme Overrides の Font Size で設定します。
static func fit_font_size(control: Control, text: String) -> void:
	# コントロールのサイズを取得します。
	var control_size = control.size
	
	# コントロールの用いるフォントを取得します。
	var font: Font = get_font(control)
	
	# 描画サイズを測定するために、テキストを描画するオブジェクトを生成します。
	# RefCounted 派生なので消去は自動的に行われます。
	var text_paragraph: TextParagraph = TextParagraph.new()
	
	# フォントサイズを１ずつ増やしていき、コントロールのサイズからはみ出ない最大のフォントサイズを探します。
	var font_size = 1 # 初期フォントサイズ
	while true:
		# 指定したフォント・フォントサイズ・テキストを設定して、その描画サイズを取得します。
		text_paragraph.clear()
		text_paragraph.add_string(text, font, font_size)
		var text_size: Vector2 = text_paragraph.get_size()
		# テキストの描画サイズがコントロールのサイズ（横または縦）を超えた場合、その直前のフォントサイズで調整します。
		if control_size.x < text_size.x or control_size.y < text_size.y:
			break
		# テキストの描画サイズがコントロールのサイズを超えない場合、さらに 1 増やしたフォントサイズで確認を繰り返します。
		font_size += 1
	
	# コントロールからはみでないフォントサイズを設定します。
	# すでに Theme Overrides で設定されている Font Size は上書きされます。
	control.add_theme_font_size_override("font_size", font_size)
	
	return

## [param control] が用いるフォントを取得します。
static func get_font(control: Control) -> Font:
	# control が使用しているフォントを取得します。
	# theme から取得する関数の引数には、テーマリソースのフォントに関する項目名 "font" (snake_case)を指定します。
	# 参照：https://docs.godotengine.org/ja/4.x/classes/class_control.html#class-control-method-get-theme-color
	var font: Font = null
	if control.has_theme_font_override("font") or control.has_theme_font("font") == true:
		# テーマの font 項目または Control クラス派生のノードが持つ Theme Overrides の font 項目が設定されている場合
		# テーマから font 項目の値(Font)を取得します。
		font = control.get_theme_font("font") 
	else:
		# フォントが設定されていない場合
		# テーマのデフォルトの font 項目の値(Font)を取得します。
		font = control.get_theme_default_font()
	
	return font
