@tool
extends Node
class_name StudySetterGetterSignal
## setter, getter, signal に関する調査のためのクラスです。
## https://compota-soft.work/archives/48622
## https://compota-soft.work/archives/48700
## https://compota-soft.work/archives/48766

## [member int_value]　が変更された際に発せられるシグナルです。
## [param int_value] は設定された新しい値です。
signal int_value_changed(int_value: int)

## setter, getter のテストを行うためのメンバ変数です。
## set, get で setter, getter の関数を割り当てることで
## この変数の値を取得する際は getter, 設定する際は setter の関数が呼び出されます。
@export var int_value: int = 0: set = set_int_value, get = get_int_value
## [param int_value] の setter 関数です。
func set_int_value(value: int) -> void:
	print("set_int_value called. value = " + str(value))
	# 値が以前と同じ場合は何もしません。
	# getter に割り当てた関数が呼ばれ、その戻り値と value を比較します。
	if int_value == value:
		return
	int_value = value	# 値を設定
	int_value_changed.emit(value)	# シグナルを発します。
	return
## [param int_value] の getter 関数です。
func get_int_value() -> int:
	# インスペクタードックにプロパティを表示している際に毎フレーム呼ばれるので print 文はコメントアウトします。
	#print("get_int_value called. int_value = " + str(int_value))
	return int_value

## $ButtonRandom を押した回数です。
var button_random_count: int = 0

# Called when the node enters the scene tree for the first time.
## シーンに、このスクリプトを割り当てたノードが。配置された直後に呼び出されるイベント関数です。
func _ready():
	# ラベルの表示を更新します。
	update_labels()
	# [signal StudySetterGetterSignal.int_value_changed] をメンバ関数と接続します。
	# シグナルは、エディタのノードドックから接続することもできます。
	int_value_changed.connect(Callable(self, "_on_int_value_changed"))
	return

## [signal StudySetterGetterSignal.int_value_changed] シグナルに接続した関数です。
## シグナルが発せられると呼び出されます。
func _on_int_value_changed(_int_value: int) -> void:
	## インスペクタードックから変更された際などに呼ばれた場合は、シーンを実行していないので表示の更新をしません。
	## シーンを実行していない、エディタで Label.text を更新すると、
	## インスペクタードックで設定している text プロパティが変化してしまいます。
	if Engine.is_editor_hint():
		# Code to execute when in editor. エディターで実行するコード。
		print("Engine.is_editor_hint() == true")
	## シーン実行中は、Label.text の表示の更新を行います。
	## シーンを実行している場合は、実行中の　Label.text だけが変化して、
	## インスペクタードックでの設定は変化しません。
	if not Engine.is_editor_hint():
		# Code to execute when in game. ゲーム中に実行するコード。
		print("Engine.is_editor_hint() == false")
		# ラベルの表示を更新します。
		update_labels()
	return

## $LabelIntValue のテキストを更新します。
func update_labels() -> void:
	# int_value の値を表示するラベルのテキストを更新します。
	# このタイミングで getter 関数が呼び出されます。
	$LabelIntValue.text = "int_value = %s" % [str(int_value)]
	# button_random_count の値を表示するラベルのテキストを更新します。
	$LabelCount.text = "( %s 回目)" % [str(button_random_count)]
	return

## $ButtonRandom の [Signal BaseButton.button_up] が発せられた際に呼び出される受信側メソッドです。
func _on_button_random_button_up():
	# ボタンを押した回数を 1 増やします。
	# 先に int_value の値を変えてしまうと、 update_labels が
	# button_random_count を加算する処理よりも早く呼ばれてしまい
	# 回数が１回遅く表示されます。 (0, 0, 1, 2,...)
	button_random_count += 1
	# 1 ~ 9 の値を加算します。
	# このタイミングで setter 関数が呼び出されます。
	# また、 setter 関数の内部で [signal StudySetterGetterSignal.int_value_changed] が発せられます。
	var random_value: int = randi_range(1, 9)
	int_value += random_value
	# 直前に加算された値を更新します。
	$LabelRandomValue.text = "+ %s" % [str(random_value)]
	return
