@tool
extends Node
class_name ScMinMaxConstraintHandler
## 外部から設定された２つのノードの任意のプロパティの数値の大小関係を維持します。
## エディタ拡張・実行時に動作します。
##
## 大小関係が逆転した場合、編集していない方の値を、大小関係を維持するように変更します。
## 例えば、小さい方が 9, 大きい方が 12 の状態から、大きい方を編集して 8 に下げた時点で
## 小さい方は 8 に変わります。
##
## 使い方の例
## 最小と最大の値を入力する 2 つの SpinBox コントロールの場合、そのどちらかに、
## このスクリプトを割り当て、インスペクタードックに表示される本スクリプトのプロパティ
## （２つのノードと、プロパティ名、数値が変更された際のシグナル名）を指定してください。
## コントロール以外のノードを作って、それにスクリプトを貼り付けて同様の設定をしても動作します。

## [member node_small] が変更された際に発せられるシグナルです。
## [param node] は、新しく設定された Node です。
signal node_small_changed(node: Node)
## [member property_path_small] が変更された際に発せられるシグナルです。
## [param property_path] は、新しく設定されたプロパティ名です。
signal property_path_small_changed(property_path: String)
## [member signal_name_small] が変更された際に発せられるシグナルです。
## [param signal_name] は、新しく設定されたシグナル名です。
signal signal_name_small_changed(signal_name: String)

## [member node_large] が変更された際に発せられるシグナルです。
## [param node] は、新しく設定された Node です。
signal node_large_changed(node: Node)
## [member property_path_large] が変更された際に発せられるシグナルです。
## [param property_path] は、新しく設定されたプロパティ名です。
signal property_path_large_changed(property_path: String)
## [member signal_name_large] が変更された際に発せられるシグナルです。
## [param signal_name] は、新しく設定されたシグナル名です。
signal signal_name_large_changed(signal_name: String)


@export_group("MinMaxConstraint") # プロパティのグループの開始

## ２つのノードのうち小さい値を持つノードをインスペクタードックから指定してください。
@export var node_small: Node = null: set = set_node_small, get = get_node_small
## [member node_small] の setter です。
func set_node_small(value: Node):
	if node_small == value:	# 値が同じならば何もしません。
		return
	node_small = value
	# [member node_small_changed] シグナルを発します。
	node_small_changed.emit(node_small)
	return
## [member node_small] の getter です。
func get_node_small() -> Node:
	return node_small

## [member node_small] の対象となるプロパティのパスをインスペクタードックから指定してください。
@export var property_path_small: String = "value": set = set_property_path_small
## [member property_path_small] の setter です。
func set_property_path_small(value: String):
	if property_path_small == value:	# 値が同じならば何もしません。
		return
	property_path_small = value
	# [member property_path_small_changed] シグナルを発します。
	property_path_small_changed.emit(property_path_small)
	return

## [member node_small] の値が変わった際のシグナル名をインスペクタードックから指定してください。
## 注意：引数を 0 ~ 9 個持つシグナルに対応しています。
@export var signal_name_small: String = "value_changed": set = set_signal_name_small
## [member signal_name_small] の setter です。
func set_signal_name_small(value: String):
	if signal_name_small == value:	# 値が同じならば何もしません。
		return
	signal_name_small = value
	# [member signal_name_small_changed] シグナルを発します。
	signal_name_small_changed.emit(signal_name_small)
	return 

## ２つのノードのうち大きい値を持つノードをインスペクタードックから指定してください。
@export var node_large: Node = null: set = set_node_large, get = get_node_large
## [member node_small] の setter です。
func set_node_large(value: Node):
	if node_large == value:	# 値が同じならば何もしません。
		return
	node_large = value
	# [membeer node_small_changed] シグナルを発します。
	node_large_changed.emit(node_large)
	return
## [member node_large] の getter です。
func get_node_large() -> Node:
	return node_large

## [member node_large] の対象となるプロパティのパスをインスペクタードックから指定してください。
@export var property_path_large: String = "value": set = set_property_path_large
## [member property_path_large] の setter です。
func set_property_path_large(value: String):
	if property_path_large == value:	# 値が同じならば何もしません。
		return
	property_path_large = value
	# [member property_path_large_changed] シグナルを発します。
	property_path_large_changed.emit(property_path_large)
	return

## [member node_small] の値が変わった際のシグナル名をインスペクタードックから指定してください。
## 注意：引数を 0 ~ 9 個持つシグナルに対応しています。
@export var signal_name_large: String = "value_changed": set = set_signal_name_large
## [member signal_name_large] の setter です。
func set_signal_name_large(value: String):
	if signal_name_large == value:	# 値が同じならば何もしません。
		return
	signal_name_large = value
	# [member signal_name_large_changed] シグナルを発します。
	signal_name_large_changed.emit(signal_name_large)
	return 

@export_group("") # プロパティのグループの終了

func _enter_tree():
	#print("sc_min_max_constraint_handler.gd : _enter_tree called.")
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#print("sc_min_max_constraint_handler.gd : _ready called.")
	# 各ノードの値が変更されたときのシグナルと、大小関係を維持するメンバ関数を接続します。
	#signal_name_small = "mouse_entered" # 0 個の引数のテスト時にコメント解除してください。マウスオーバーで emit します。
	var error_code = node_small.connect(signal_name_small, Callable(self, "_on_node_small_value_changed"))
	#print("error_code = " + str(error_code))
	if error_code == ERR_INVALID_PARAMETER:
		print("ERR_INVALID_PARAMETER ")
	#print("node_small.is_connected(signale_name_small) = " + str(node_small.is_connected(signal_name_small, Callable(self, "_on_node_small_value_changed"))))
	
	node_large.connect(signal_name_large, Callable(self, "_on_node_large_value_changed"))
	return

## [member node_small] の値が変更された際に呼び出される関数です。
## [member node_large] の値よりも大きい値になった場合、
## [member node_small] の値を [member node_large] の値に変更して
## 二つの Node の値を等しくして、大小関係を維持します。
## 注意：引数の個数が 0 ~ 9 個までのシグナルに対応しています。
func _on_node_small_value_changed(_arg1 = null, _arg2 = null, _arg3 = null, _arg4 = null, _arg5 = null, _arg6 = null, _arg7 = null, _arg8 = null, _arg9 = null) -> void:
	#print("sc_min_max_constraint_handler.gd : _on_node_small_value_changed called.")
	var value_small: int = node_small.get(property_path_small)
	var value_large: int = node_large.get(property_path_large)
	if value_small > value_large:
		node_large.set(property_path_large, value_small)
	return

## [member node_large] の値が変更された際に呼び出される関数です。可変長引数にして任意の引数に応じます。
## [member node_small] の値よりも小さい値になった場合、
## [member node_large] の値を [member node_small] の値に変更して
## 二つの Node の値を等しくして、大小関係を維持します。
## 注意：引数の個数が 0 ~ 9 個までのシグナルに対応しています。
func _on_node_large_value_changed(_arg1 = null, _arg2 = null, _arg3 = null, _arg4 = null, _arg5 = null, _arg6 = null, _arg7 = null, _arg8 = null, _arg9 = null) -> void:
	#print("sc_min_max_constraint_handler.gd : _on_node_large_value_changed called.")
	var value_small: int = node_small.get(property_path_small)
	var value_large: int = node_large.get(property_path_large)
	if value_small > value_large:
		node_small.set(property_path_small, value_large)
	return
