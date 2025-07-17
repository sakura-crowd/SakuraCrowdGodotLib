extends Node
class_name ScStudyPseudoVarargs
## 実際には有限な引数を扱う疑似的な可変長引数の実装方法について調べるためのクラスです。
## メンバ関数呼び出しの他に、シグナルの引数にも対応できるかを確認します。
## [member pseudo_varargs_function] のようなインターフェースを持つことで疑似的に可変長引数を扱えます。

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect のエラーコードを得る変数。
	# 参照 https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-error
	var error_code = OK	# OK = 0
	
	# 引数 0 ～ 9 を持つ各シグナルを同じ関数に接続するテスト
	error_code = self.connect("study_pseudo_varargs_signal_arg_0", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_0 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_1", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_1 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_2", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_2 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_3", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_3 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_4", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_4 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_5", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_5 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_6", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_6 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_7", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_7 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_8", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_8 error_code = " + str(error_code))
	error_code = self.connect("study_pseudo_varargs_signal_arg_9", Callable(self, "pseudo_varargs_function"))
	print("connect study_pseudo_varargs_signal_arg_9 error_code = " + str(error_code))
	# 通常の関数呼び出しのテスト
	print("pseudo_varargs_function(0 args) call")
	pseudo_varargs_function()
	print("pseudo_varargs_function(1 args) call")
	pseudo_varargs_function("A")
	print("pseudo_varargs_function(2 args) call")
	pseudo_varargs_function("A", "B")
	print("pseudo_varargs_function(3 args) call")
	pseudo_varargs_function("A", "B", "C")
	print("pseudo_varargs_function(4 args) call")
	pseudo_varargs_function("A", "B", "C", "D")
	print("pseudo_varargs_function(5 args) call")
	pseudo_varargs_function("A", "B", "C", "D", "E")
	print("pseudo_varargs_function(6 args) call")
	pseudo_varargs_function("A", "B", "C", "D", "E", "F")
	print("pseudo_varargs_function(7 args) call")
	pseudo_varargs_function("A", "B", "C", "D", "E", "F", "G")
	print("pseudo_varargs_function(8 args) call")
	pseudo_varargs_function("A", "B", "C", "D", "E", "F", "G", "H")
	print("pseudo_varargs_function(9 args) call")
	pseudo_varargs_function("A", "B", "C", "D", "E", "F", "G", "H", "I")
	return

func _process(_delta):
	# key 0 ~ 9 がおされた直後のフレームに signal を emit します。
	# signal の呼び出しのため、エディタでこのスクリプトを割り当てたノードを持つシーンを実行して
	# 0 ~ 9 のキーを押下してください。
	var just_pressed = true
	if Input.is_key_pressed(KEY_0) and just_pressed:
		print("study_pseudo_varargs_signal_arg_0.emit")
		study_pseudo_varargs_signal_arg_0.emit()
	elif Input.is_key_pressed(KEY_1) and just_pressed:
		print("study_pseudo_varargs_signal_arg_1.emit")
		study_pseudo_varargs_signal_arg_1.emit(1)
	elif Input.is_key_pressed(KEY_2) and just_pressed:
		print("study_pseudo_varargs_signal_arg_2.emit")
		study_pseudo_varargs_signal_arg_2.emit(1, 2)
	elif Input.is_key_pressed(KEY_3) and just_pressed:
		print("study_pseudo_varargs_signal_arg_3.emit")
		study_pseudo_varargs_signal_arg_3.emit(1, 2, 3)
	elif Input.is_key_pressed(KEY_4) and just_pressed:
		print("study_pseudo_varargs_signal_arg_4.emit")
		study_pseudo_varargs_signal_arg_4.emit(1, 2, 3, 4)
	elif Input.is_key_pressed(KEY_5) and just_pressed:
		print("study_pseudo_varargs_signal_arg_5.emit")
		study_pseudo_varargs_signal_arg_5.emit(1, 2, 3, 4, 5)
	elif Input.is_key_pressed(KEY_6) and just_pressed:
		print("study_pseudo_varargs_signal_arg_6.emit")
		study_pseudo_varargs_signal_arg_6.emit(1, 2, 3, 4, 5, 6)
	elif Input.is_key_pressed(KEY_7) and just_pressed:
		print("study_pseudo_varargs_signal_arg_7.emit")
		study_pseudo_varargs_signal_arg_7.emit(1, 2, 3, 4, 5, 6, 7)
	elif Input.is_key_pressed(KEY_8) and just_pressed:
		print("study_pseudo_varargs_signal_arg_8.emit")
		study_pseudo_varargs_signal_arg_8.emit(1, 2, 3, 4, 5, 6, 7, 8)
	elif Input.is_key_pressed(KEY_9) and just_pressed:
		print("study_pseudo_varargs_signal_arg_9.emit")
		study_pseudo_varargs_signal_arg_9.emit(1, 2, 3, 4, 5, 6, 7, 8, 9)
	return

func _input(event):
	# key 0 ~ 9 がおされた直後のフレームに signal を emit します。
	# signal の呼び出しのため、エディタでこのスクリプトを割り当てたノードを持つシーンを実行して
	# 0 ~ 9 のキーを押下してください。
	var just_pressed: bool = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_0) and just_pressed:
		print("study_pseudo_varargs_signal_arg_0.emit")
		study_pseudo_varargs_signal_arg_0.emit()
	elif Input.is_key_pressed(KEY_1) and just_pressed:
		print("study_pseudo_varargs_signal_arg_1.emit")
		study_pseudo_varargs_signal_arg_1.emit(1)
	elif Input.is_key_pressed(KEY_2) and just_pressed:
		print("study_pseudo_varargs_signal_arg_2.emit")
		study_pseudo_varargs_signal_arg_2.emit(1, 2)
	elif Input.is_key_pressed(KEY_3) and just_pressed:
		print("study_pseudo_varargs_signal_arg_3.emit")
		study_pseudo_varargs_signal_arg_3.emit(1, 2, 3)
	elif Input.is_key_pressed(KEY_4) and just_pressed:
		print("study_pseudo_varargs_signal_arg_4.emit")
		study_pseudo_varargs_signal_arg_4.emit(1, 2, 3, 4)
	elif Input.is_key_pressed(KEY_5) and just_pressed:
		print("study_pseudo_varargs_signal_arg_5.emit")
		study_pseudo_varargs_signal_arg_5.emit(1, 2, 3, 4, 5)
	elif Input.is_key_pressed(KEY_6) and just_pressed:
		print("study_pseudo_varargs_signal_arg_6.emit")
		study_pseudo_varargs_signal_arg_6.emit(1, 2, 3, 4, 5, 6)
	elif Input.is_key_pressed(KEY_7) and just_pressed:
		print("study_pseudo_varargs_signal_arg_7.emit")
		study_pseudo_varargs_signal_arg_7.emit(1, 2, 3, 4, 5, 6, 7)
	elif Input.is_key_pressed(KEY_8) and just_pressed:
		print("study_pseudo_varargs_signal_arg_8.emit")
		study_pseudo_varargs_signal_arg_8.emit(1, 2, 3, 4, 5, 6, 7, 8)
	elif Input.is_key_pressed(KEY_9) and just_pressed:
		print("study_pseudo_varargs_signal_arg_9.emit")
		study_pseudo_varargs_signal_arg_9.emit(1, 2, 3, 4, 5, 6, 7, 8, 9)
	return

## 引数が 0 ~ 9 個のそれぞれの数字のキーを押されたときに emit されるシグナルです。
signal study_pseudo_varargs_signal_arg_0
signal study_pseudo_varargs_signal_arg_1(arg1)
signal study_pseudo_varargs_signal_arg_2(arg1, arg2)
signal study_pseudo_varargs_signal_arg_3(arg1, arg2, arg3)
signal study_pseudo_varargs_signal_arg_4(arg1, arg2, arg3, arg4)
signal study_pseudo_varargs_signal_arg_5(arg1, arg2, arg3, arg4, arg5)
signal study_pseudo_varargs_signal_arg_6(arg1, arg2, arg3, arg4, arg5, arg6)
signal study_pseudo_varargs_signal_arg_7(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
signal study_pseudo_varargs_signal_arg_8(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
signal study_pseudo_varargs_signal_arg_9(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)

## 引数が 0 ~ 9 個の任意の個数で呼び出される関数です。引数を, 区切りで出力します。
## signal, 関数呼び出しで利用できることを確認します。
func pseudo_varargs_function(_arg1 = null, _arg2 = null, _arg3 = null, _arg4 = null, _arg5 = null, _arg6 = null, _arg7 = null, _arg8 = null, _arg9 = null) -> void:
	var string_args = str(_arg1)
	string_args += ", " + str(_arg2)
	string_args += ", " + str(_arg3)
	string_args += ", " + str(_arg4)
	string_args += ", " + str(_arg5)
	string_args += ", " + str(_arg6)
	string_args += ", " + str(_arg7)
	string_args += ", " + str(_arg8)
	string_args += ", " + str(_arg9)
	print("study_pseudo_varargs.gd : pseudo_varargs_function called.")
	print("string_args = " + string_args)
	return
