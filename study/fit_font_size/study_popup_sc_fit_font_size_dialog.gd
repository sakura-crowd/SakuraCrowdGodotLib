extends Control

## パラメータを入力するダイアログのシーンです。
const sc_fit_font_size_dialog_scene: PackedScene = preload("res://addons/sc_fit_font_size/sc_fit_font_size_dialog.tscn")
## sc_fit_font_size_dialog_scene シーンを実体化したダイアログです。
var sc_fit_font_size_dialog: AcceptDialog = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# ダイアログはボタンが押されるまで無効です。
	sc_fit_font_size_dialog = null
	print("sc_fit_font_size.gd: _enter_tree called")
	return

## プラグインの後片付けの処理を定義します。
## プラグインを無効 (プロジェクト設定ダイアログ＞プラグイン＞有効) にした直後や、プラグインが有効な状態のプロジェクトを閉じた際に呼び出されます。
func _exit_tree():
	# Clean-up of the plugin goes here.
	_free_dialog()	# もしも解放されていなければ、ダイアログを解放します。
	print("sc_fit_font_size.gd: _exit_tree called")

## $Button の button_up シグナルの受信側メソッドです。
## 動作確認のため最大最小を設定するダイアログを表示します。
func _on_button_button_up():
	_free_dialog()	# もしも解放されていなければ、ダイアログを解放します。
	
	# ダイアログのシーンを実体化します。
	sc_fit_font_size_dialog = sc_fit_font_size_dialog_scene.instantiate()
	# ダイアログに Cancel ボタンを追加します。
	sc_fit_font_size_dialog.add_cancel_button("Cancel")
	# ダイアログに配置されているコントロール群にフィットするようにサイズを調整するために 0 を設定します。
	# これにより、最小限の Window のサイズが自動的に設定されます。インスペクターでも同様の方法を実行できます。
	sc_fit_font_size_dialog.size = Vector2(0, 0)
	# ダイアログの OK ボタン、 Cancel ボタンと関数を関連付けます。
	sc_fit_font_size_dialog.connect("confirmed", Callable(self, "_on_dialog_confirmed"))
	sc_fit_font_size_dialog.connect("canceled", Callable(self, "_on_dialog_canceled"))
	get_tree().root.add_child(sc_fit_font_size_dialog)
	
	## パラメータを入力するダイアログを表示します。
	sc_fit_font_size_dialog.popup_centered()
	return

## ダイアログで OK ボタンが押された際に呼び出される関数です。
func _on_dialog_confirmed():
	print("_on_dialog_confirmed called.")
	print_dialog_parameter()	# ダイアログの SpinBoxMin, SpinBoxMax の値を出力します。
	_free_dialog()	# ダイアログを解放します。
	return

## ダイアログで Cancel ボタンが押された際に呼び出される関数です。
func _on_dialog_canceled():
	print("_on_dialog_canceled called.")
	print_dialog_parameter()	# ダイアログの SpinBoxMin, SpinBoxMax の値を出力します。
	_free_dialog()	# ダイアログを解放します。
	return

## ダイアログを解放して [member sc_fit_font_size_dialog] を null に設定します。
## [member sc_fit_font_size_dialog] の使用が完了した際に呼び出します。
func _free_dialog():
	# ダイアログがもしも消されていない場合は解放します。
	if sc_fit_font_size_dialog != null:
		sc_fit_font_size_dialog.queue_free()
		sc_fit_font_size_dialog = null
	return

## デバッグ用。 [member sc_fit_font_size_dialog] の２個 SpinBox の値を print 関数で出力します。
func print_dialog_parameter() -> void:
	# ダイアログがない場合はエラーメッセージを出力して戻ります。
	if sc_fit_font_size_dialog == null:
		push_error("sc_fit_font_size.gd: sc_fit_font_size_dialog == null")
		return
	# ダイアログに配置されている SpinBox コントロールを取得します。
	var spin_box_min: SpinBox = sc_fit_font_size_dialog.find_child("SpinBoxMin")
	var spin_box_max: SpinBox = sc_fit_font_size_dialog.find_child("SpinBoxMax")
	# SpinBox が見つからない場合はエラーメッセージを出力して戻ります。
	if spin_box_min == null or spin_box_max == null:
		push_error("sc_fit_font_size.gd: spin_box_min == null or spin_box_max == null")
		return
	# SpinBox の値を出力ボトムパネルに表示します。
	print("SpinBoxMin.value = " + str(spin_box_min.value) + ", SpinBoxMax.value = " + str(spin_box_max.value))
	return
