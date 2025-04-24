extends Control
class_name ScStudyInputKey
## キーが押されたことを判定する処理についての確認を行うためのクラスです。
## 同名のシーンを実行して、1 キーを押すと InputEvent を用いない判定、 
## 2 キーを押すと InputEvent を用いる判定が行われます。
## シーンには、1, 2 キーが押されているときに色が変わる ColorRect や、
## キーが押されたと判定された回数を表示するラベルが配置されています。
## 本スクリプトでは、判定処理の関数の他に、シーンの UI の更新も行います。

## KEY_1 が押された回数です。
## 計測方法は [member is_press_key1_process] 関数です。
var count_key_1_pressed: int  = 0

## KEY_2 が押された回数です。
## 計測方法は [member is_press_key2_input] 関数です。
var count_key_2_pressed: int  = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	# キー入力の有無により ColorRect の色を変えます。
	if Input.is_key_pressed(KEY_1):
		$ColorRectKey1.color = Color.PALE_VIOLET_RED
	else:
		$ColorRectKey1.color = Color.WHITE
	if Input.is_key_pressed(KEY_2):
		$ColorRectKey2.color = Color.PALE_VIOLET_RED
	else:
		$ColorRectKey2.color = Color.WHITE
	# 各方法で検出したキーの押下された回数を表示するラベルを更新します。
	$LabelCount.text  = "Key 1 (_process) : " + str(count_key_1_pressed) + "\n"
	$LabelCount.text += "Key 2 (_input)   : " + str(count_key_2_pressed)
	
	# 以下の関数でキー 1 が押されたことを検出した場合は、key 1 のカウントを１増やします。
	if is_key_pressed_at_process(_delta) == true:
		count_key_1_pressed += 1
	return

func _input(event: InputEvent):
	# 以下の関数でキー 2 が押されたことを検出した場合は、key 2 のカウントを１増やします。
	if is_key_pressed_at_input(event) == true:
		count_key_2_pressed += 1
	return

## _process 関数で Input.is_key_pressed を用いて KEY_1 が押されたかを判定します。
## 結果として、押され続けている間、毎回 true を返します。
func is_key_pressed_at_process(_delta) -> bool:
	return Input.is_key_pressed(KEY_1)

## _input 関数で　event 引数の情報 (is_pressed, is_echo)と Input.is_key_pressed を組み合わせて KEY_2 が押されたかを判定します。
## 結果として、押された直後の呼び出しのみ true を返します。
func is_key_pressed_at_input(event: InputEvent) -> bool:
	var just_pressed: bool = event.is_pressed() and not event.is_echo()
	return Input.is_key_pressed(KEY_2) and just_pressed
