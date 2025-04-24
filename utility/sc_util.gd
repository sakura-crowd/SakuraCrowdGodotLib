extends Object
class_name ScUtil
## SakuraCrowd が作成したユーティリティ関数群です。
##
## 自作の static 関数群です。行数が増えたら、機能ごとに分けるかもしれません。
## 本スクリプトは自己責任でご使用ください。
## 
## push_error, push_warning を使うと print 文よりもわかりやすいです。
##
## 以下は BB Code を使用する際のサンプルです。
## BB Code の[url=https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_documentation_comments.html]公式サイトのサンプル[/url]を以下に記述します。[br]
## ■ クラスへのリンク。[br]
## Move the [lb]Sprite2D[rb]. → Move the [Sprite2D].
## [br][br]
## ■ アノテーションへのリンク[br]
## See [lb]annotation @GDScript.@rpc[rb]. → See [annotation @GDScript.@rpc].[br]
## See [lb]annotation @GDScript.@export[rb]. → See [annotation @GDScript.@export].[br]
## [br][br]
## ■ 定数へのリンク[br]
## See [lb]constant Color.RED[rb]. → See [constant Color.RED].
## [br][br]
## ■ 列挙子へのリンク[br]
## See [lb]enum Mesh.ArrayType[rb]. → See [enum Mesh.ArrayType].
## [br][br]
## ■ メンバ変数・プロパティへのリンク[br]
## Get [lb]member Node2D.scale[rb]. → Get [member Node2D.scale].
## [br][br]
## ■ 関数へのリンク[br]
## Call [lb]method Node3D.hide[rb]. → Call [method Node3D.hide].
## [br][br]
## ■ コンストラクタへのリンク[br]
## Use [lb]constructor Color.Color[rb]. → Use [constructor Color.Color].
## [br][br]
## ■ 演算子へのリンク[br]
## Use [lb]operator Color.operator *[rb]. → Use [operator Color.operator *].
## [br][br]
## ■ シグナルへのリンク[br]
## Emit [lb]signal Node.renamed[rb]. → Emit [signal Node.renamed].
## [br][br]
## ■ theme item へのリンク[br]
## See [lb]theme_item Label.font[rb]. → See [theme_item Label.font].
## [br][br]
## ■ 引数名[br]
## Takes [lb]param size[rb] for the size. → Takes [param size] for the size.
## [br][br]
## ■ 改行[br]
## Line 1.[lb]br[rb]Line 2. → [br]
## Line 1.[br]
## Line 2.
## [br][br]
## ■ [lb] と [rb] を文字列として表記[br]
## [lb]lb[rb]b[lb]rb[rb]text[lb]lb[rb]/b[lb]rb[rb] → [lb]b[rb]text[lb]/b[rb]
## [br][br]
## ■ 太字[br]
## Do [lb]b[rb]not[lb]/b[rb] call this method. → Do [b]not[/b] call this method.
## [br][br]
## ■ イタリック体[br]
## Returns the [lb]i[rb]global[lb]/i[rb] position. → Returns the [i]global[/i] position.
## [br][br]
## ■ 下線[br]
## [lb]u[rb]Always[lb]/u[rb] use this method. → [u]Always[/u] use this method.
## [br][br]
## ■ 打消し線[br]
## [lb]s[rb]Outdated information.[lb]/s[rb] → [s]Outdated information.[/s]
## [br][br]
## ■ 文字の色[br]
## [lb]color=red[rb]Error![lb]/color[rb] → [color=red]Error![/color]
## [br][br]
## ■ フォント(プロジェクトにない場合は、エラーが下パネルの出力に表示されます)[br]
## ・そのフォント (mono.ttf) のパスが無効な場合[br]
## [lb]font=res://mono.ttf[rb]LICENSE[lb]/font[rb] → [font=res://mono.ttf]LICENSE[/font][br]
## ・そのフォント (mplus-1p-regular.ttf) のパスが有効な場合[br]
## [lb]font=res://mplus-1p-regular.ttf[rb]LICENSE[lb]/font[rb] → [font=res://mplus-1p-regular.ttf]LICENSE[/font]
## [br][br]
## ■ 画像[br]
## [lb]img width=32[rb]res://icon.svg[lb]/img[rb] → [img width=32]res://icon.svg[/img]
## [br][br]
## ■ URL リンク[br]
## [lb]url[rb]https://example.com[lb]/url[rb] → [url]https://example.com[/url][br]
## [lb]url=https://example.com[rb]Website[lb]/url[rb] → [url=https://example.com]Website[/url]
## [br][br]
## ■ 中央寄せ[br]
## [lb]center[rb]2 + 2 = 4[lb]/center[rb] → [center]2 + 2 = 4[/center]
## [br][br]
## ■ キーボード・マウス入力のガイド[br]
## Press [lb]kbd[rb]Ctrl + C[lb]/kbd[rb]. → Press [kbd]Ctrl + C[/kbd].
## [br][br]
## ■ コードの表記[br]
## Returns [lb]code[rb]true[lb]/code[rb]. → Returns [code]true[/code].
## [br][br]
## ■ 複数行のコードの表記[br]
## [lb]codeblock[rb][br]
## func greet(name: String) -> void:[br]
## 	print("Hello, wolrd! Hello, ", name)[br]
## 	return[br]
## [lb]codeblock[rb][br]
## [codeblock]
## func greet(name: String) -> void:
## 	print("Hello, wolrd! Hello, ", name)
## 	return
## [/codeblock]
## [br][br]
	
## [method SakuraCrowdUtil.debug_print] でテキストを標準出力する基準値です。未満の場合は出力されません。
static var debug_print_level:int = 100

## [b]デバッグ用の print 関数です。
## [br]
## [method OS.is_debug_build] が有効で、[param level] が [member SakuraCrowdUtil.debug_print_level] 以上の場合に標準出力します。
static func debug_print(message: String, level: int = 10) -> void:
	if OS.is_debug_build() and debug_print_level < level:
		print(message)

## メッセージ入力済みのツイート用のウェブページを表示します。
static func tweet(message: String) -> void:
	OS.shell_open("https://x.com/intent/post?text=" + message)
	return

# ------
# Object
# ------
## [b]プロパティを全てテキストで出力します。[/b][br]
## [br]
## [param object] の持つプロパティの名前と値の文字列を１行ずつ出力します。[br]
## 形式については [method SakuraCrowdUtil.get_all_property_name_and_value] 関数を参照してください。[br]
static func print_all_property_name_and_value(object: Object) -> void:
	# object のプロパティ１つずつを文字列として格納した配列を取得します。
	var string_array: Array[String] = get_all_property_name_and_value(object)
	# プロパティの文字列を１行ずつ（プラパティ１つずつ）出力します。
	for string in string_array:
		print(string)
	return

## [b]プロパティごとに変換した文字列の配列を得ます。[/b][br]
## [br]
## [param object] の持つプロパティの名前と値を「名前: 値」の形式の文字列の配列として返します。[br]
static func get_all_property_name_and_value(object: Object) -> Array[String]:
	# 戻り値の変数です。この配列にプロパティの文字列を１行ずつ追加します。
	var properties: Array[String]
	# object が持つすべてのプロパティの名前や値の辞書型変数を取得します。
	var prop_list = object.get_property_list()
	
	# プロパティの辞書型変数を１つずつ処理します。３つのプロパティがあれば３回繰り返します。
	for prop in prop_list:
		# プロパティの名前と値と型番号を取得します。
		var prop_name = prop.name
		var prop_value = object.get(prop_name)
		var prop_type = prop.type
		# 型に応じて値を文字列に変換します。
		prop_value = to_string_from_property_value(prop_value, prop_type)
		# 「名前: 値」の形式の文字列を配列に追加します。
		properties.append(prop_name + ": " + prop_value)	
	
	return properties

## [b][enum Variant.Type] に対応する型に応じて、値を文字列に変換して返します。[/b][br]
## [br]
## [enum Variant.Type] に応じて、値を文字列に変換します。[br]
## [enum Variant.Type] に定義されていない値の場合は 「Unknown type = 39」などのように [param prop_type] の番号を最後に加えた文字列を返します。[br]
static func to_string_from_property_value(prop_value, prop_type: int) -> String:
	# 型に応じて (Variant.Type) 値を文字列に変換します。
	match prop_type:
		TYPE_NIL:
			prop_value = "null"
		TYPE_BOOL:
			prop_value = str(prop_value)
		TYPE_INT:
			prop_value = str(prop_value)
		TYPE_FLOAT:
			prop_value = str(prop_value)
		TYPE_STRING:
			prop_value = prop_value
		TYPE_VECTOR2:
			prop_value = str(prop_value)
		TYPE_VECTOR2I:
			prop_value = str(prop_value)
		TYPE_RECT2:
			prop_value = str(prop_value)
		TYPE_RECT2I:
			prop_value = str(prop_value)
		TYPE_VECTOR3:
			prop_value = str(prop_value)
		TYPE_VECTOR3I:
			prop_value = str(prop_value)
		TYPE_TRANSFORM2D:
			prop_value = str(prop_value)
		TYPE_VECTOR4:
			prop_value = str(prop_value)
		TYPE_VECTOR4I:
			prop_value = str(prop_value)
		TYPE_PLANE:
			prop_value = str(prop_value)
		TYPE_QUATERNION:
			prop_value = str(prop_value)
		TYPE_AABB:
			prop_value = str(prop_value)
		TYPE_BASIS:
			prop_value = str(prop_value)
		TYPE_TRANSFORM3D:
			prop_value = str(prop_value)
		TYPE_PROJECTION:
			prop_value = str(prop_value)
		TYPE_COLOR:
			prop_value = str(prop_value)
		TYPE_STRING_NAME:
			prop_value = str(prop_value)
		TYPE_NODE_PATH:
			prop_value = str(prop_value)
		TYPE_RID:
			prop_value = str(prop_value)
		TYPE_OBJECT:
			prop_value = str(prop_value)
		TYPE_CALLABLE:
			prop_value = str(prop_value)
		TYPE_SIGNAL:
			prop_value = str(prop_value)
		TYPE_DICTIONARY:
			prop_value = str(prop_value)
		TYPE_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_BYTE_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_INT32_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_INT64_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_FLOAT32_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_FLOAT64_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_STRING_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_VECTOR2_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_VECTOR3_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_COLOR_ARRAY:
			prop_value = str(prop_value)
		TYPE_PACKED_VECTOR4_ARRAY:
			prop_value = str(prop_value)
		_:
			# Variant.Type に該当しない prop_type の場合は、Unknown type = %prop_type% の形式の文字列を設定します。
			prop_value = str("Unknown type = ", str(prop_type))
	return prop_value

## [b][enum Variant.Type] の定義名を返します。不明な場合は警告文を出力して "" を返します。[/b][br]
## [param variant_type] [enum Variant.Type] を指定します。
## 参照：https://docs.godotengine.org/ja/4.x/classes/class_@globalscope.html
static func get_variant_type_name(variant_type: int) -> String:
	var type_name: String = ""
	# 型に応じて (Variant.Type) 値を文字列に変換します。
	match variant_type:
		TYPE_NIL:
			type_name = "TYPE_NIL"
		TYPE_BOOL:
			type_name = "TYPE_BOOL"
		TYPE_INT:
			type_name = "TYPE_INT"
		TYPE_FLOAT:
			type_name = "TYPE_FLOAT"
		TYPE_STRING:
			type_name = "TYPE_STRING"
		TYPE_VECTOR2:
			type_name = "TYPE_VECTOR2"
		TYPE_VECTOR2I:
			type_name = "TYPE_VECTOR2I"
		TYPE_RECT2:
			type_name = "TYPE_RECT2"
		TYPE_RECT2I:
			type_name = "TYPE_RECT2I"
		TYPE_VECTOR3:
			type_name = "TYPE_VECTOR3"
		TYPE_VECTOR3I:
			type_name = "TYPE_VECTOR3I"
		TYPE_TRANSFORM2D:
			type_name = "TYPE_TRANSFORM2D"
		TYPE_VECTOR4:
			type_name = "TYPE_VECTOR4"
		TYPE_VECTOR4I:
			type_name = "TYPE_VECTOR4I"
		TYPE_PLANE:
			type_name = "TYPE_PLANE"
		TYPE_QUATERNION:
			type_name = "TYPE_QUATERNION"
		TYPE_AABB:
			type_name = "TYPE_AABB"
		TYPE_BASIS:
			type_name = "TYPE_BASIS"
		TYPE_TRANSFORM3D:
			type_name = "TYPE_TRANSFORM3D"
		TYPE_PROJECTION:
			type_name = "TYPE_PROJECTION"
		TYPE_COLOR:
			type_name = "TYPE_COLOR"
		TYPE_STRING_NAME:
			type_name = "TYPE_STRING_NAME"
		TYPE_NODE_PATH:
			type_name = "TYPE_NODE_PATH"
		TYPE_RID:
			type_name = "TYPE_RID"
		TYPE_OBJECT:
			type_name = "TYPE_OBJECT"
		TYPE_CALLABLE:
			type_name = "TYPE_CALLABLE"
		TYPE_SIGNAL:
			type_name = "TYPE_SIGNAL"
		TYPE_DICTIONARY:
			type_name = "TYPE_DICTIONARY"
		TYPE_ARRAY:
			type_name = "TYPE_ARRAY"
		TYPE_PACKED_BYTE_ARRAY:
			type_name = "TYPE_PACKED_BYTE_ARRAY"
		TYPE_PACKED_INT32_ARRAY:
			type_name = "TYPE_PACKED_INT32_ARRAY"
		TYPE_PACKED_INT64_ARRAY:
			type_name = "TYPE_PACKED_INT64_ARRAY"
		TYPE_PACKED_FLOAT32_ARRAY:
			type_name = "TYPE_PACKED_FLOAT32_ARRAY"
		TYPE_PACKED_FLOAT64_ARRAY:
			type_name = "TYPE_PACKED_FLOAT64_ARRAY"
		TYPE_PACKED_STRING_ARRAY:
			type_name = "TYPE_PACKED_STRING_ARRAY"
		TYPE_PACKED_VECTOR2_ARRAY:
			type_name = "TYPE_PACKED_VECTOR2_ARRAY"
		TYPE_PACKED_VECTOR3_ARRAY:
			type_name = "TYPE_PACKED_VECTOR3_ARRAY"
		TYPE_PACKED_COLOR_ARRAY:
			type_name = "TYPE_PACKED_COLOR_ARRAY"
		TYPE_PACKED_VECTOR4_ARRAY:
			type_name = "TYPE_PACKED_VECTOR4_ARRAY"
		_:
			# Variant.Type に該当しない prop_type の場合は、Unknown type = %prop_type% の形式の文字列を設定します。
			push_warning("Unknown type = %s" % [str(variant_type)])
	return type_name

# -----
# Array
# -----
## [param array] の要素をキーとして、それぞれの要素の個数を値に設定した辞書を返します。
## 辞書型のキーが一意である特性を利用して、そのキーに array の要素を割り当て、要素ごとの個数の集計結果を返します。
## 例えば ["A", B", "C", "C", "C", "A"] という配列を引数にした場合 {"A": 2, "B": 1, "C": 3}という辞書が返されます。
## 特定の要素の個数を得るならば [method Array.count] の方が簡単です。
static func get_array_element_counts(array: Array) -> Dictionary:
	var element_counts: Dictionary = {}
	for element in array:
		# すでにその要素をキーとして設定している場合は、その要素のキーのカウントを加算します。
		if element in element_counts:
			element_counts[element] += 1
		# その要素のキーがまだ存在しない場合は、１個目なので、そのキーの値に int 型の 1 を設定します。
		# これを行わずに += 1 を行うと「Invalid access to property or key 'A' on a base object ob tpe 'Dictionary'.」エラーが発生します。
		else:
			element_counts[element] = 1
	return element_counts

## [param array] の要素から重複を除いた配列に変換した結果を返します。
## 辞書型のキーは一意な特性を利用して、配列の要素から重複を除いたユニークな配列を作成します。
## 例えば ["A", "B", "C", "C", "C", "A"] の場合 ["A", "B", "C"] に変換します。
static func to_unique_array(array: Array) -> Array:
	var dictionary: Dictionary = {}
	for element in array:
		# 配列の要素をキーとして、値を設定します。これにより重複しないキーに対応する値が割り当てられます。
		# 値に特に意味はありません。
		dictionary[element] = true
	# 一意のキーの配列を返します。
	return dictionary.keys()

# ----------
# Dictionary
# ----------
## 辞書型の要素を持つ配列 [param array_dictionary] から、指定したキーの値を抽出して、配列 [param dest_array] に追加します。
## 指定したキーがない場合は何もしません。
static func get_array_dictionary_specified_key_values(array_dictionary: Array[Dictionary], key: StringName, dest_array: Array) -> void:
	for dictionary: Dictionary in array_dictionary:
		if dictionary.has(key) == true:
			dest_array.append(dictionary.get(key))
	return

## 辞書型の要素を持つ配列 [param array_dictionary] で、指定したキーと値を持つ辞書を抽出して、配列 [param dest_array] に追加します。
## [param value] に配列を渡すと、複数の値を条件として指定できます。その場合、配列の要素のいずれかと同じ値ならば辞書が抽出されます。
## [param value] に配列自体を条件の値として渡したい場合は、配列の中にその配列を指定してください。
## [param value] が配列ではない場合は、その１つの値と一致する場合のみ抽出されます。
static func get_array_dictionary_matched_dictionary(array_dictionary: Array[Dictionary], key: StringName, value, dest_array: Array):
	var values = value
	if not value is Array:
		values = [value]
		
	for dictionary in array_dictionary:
		if dictionary.has(key) == true:
			var _value = dictionary.get(key)
			if _value in values:
			#if _value != null and _value == value:
				dest_array.append(dictionary)
	return

## [param object] の持つ Array や Dictionary をタブで整形して、項目ごとに改行した文字列を返します。
static func to_pretty_print_string(object) -> String:
	var string: String = to_pretty_print_string_recursive(object)
	return string

## [param data] の持つ Array や Dictionary をタブで整形して、項目ごとに改行した文字列を返します。
## 再帰的に呼びだして、Array や Dictionary の複数階層に対応します。
## 階層の一部を整形したい場合などに、初期のタブ数を指定して利用できます。
##
## 値は、文字列の場合は "" で括ります。 StringName は & つきの "" で括ります。他は括りません。
## json 形式で処理したい場合は、 &" を " に置き換えるなどしてください。
##
## [param numof_tab] は最初につけるタブ数です。
## [param string] は、それまでに作成してきた文字列が格納されています。
## [param no_tab_first] は最初の要素にタブをつけないで、すぐに要素の文字列を追加することを指定します。
## これは、呼び出し元がすでに辞書の \t"keys": まで入力してある状況などの際に用います。
## [param no_comma_first] は最初の要素の最後（配列や辞書の場合は最後の ] や } の後）に , をつけない場合は true を指定します。
## return は、[param string] に追記した [param data] の整形した文字列を返します。
##
## 用例は以下です。シグナルのリスト（Array[Dictionary]）を、整形して出力します。
## [Object.get_signal_list] 関数はそのオブジェクトが持つシグナルのリストを返します。
## 参照： https://docs.godotengine.org/ja/4.x/classes/class_object.html#class-object-method-get-signal-list
## [codeblock]
## var signal_list: Array[Dictionary] = self.get_signal_list()
## var string = ScUtil.to_pretty_print_string(signal_list)
## print(string)
## [/codeblock]
## TODO: print_rich 出力用にカラーを指定できるバージョンも作りたい。
static func to_pretty_print_string_recursive(data, numof_tab: int = 0, string: String = "", no_tab_first: bool = false, no_comma_first: bool = true) -> String:
	if data is Array:
		var array := data as Array
		var size = array.size()
		if size <= 0:
			string += make_tabs_and_string("[]\n", numof_tab, no_tab_first)
		else:
			string += make_tabs_and_string("[\n", numof_tab, no_tab_first)
			var count: int = 0
			for element in array:
				# 最後の要素の末尾には , をつけません。
				if count >= (size - 1):
					string = to_pretty_print_string_recursive(element, numof_tab + 1, string, false, true)
				else:
					string = to_pretty_print_string_recursive(element, numof_tab + 1, string, false, false)
				count += 1
			if no_comma_first == true:
				string += make_tabs_and_string("]\n", numof_tab, false)
			else:
				string += make_tabs_and_string("],\n", numof_tab, false)
	elif data is Dictionary:
		var dictionary := data as Dictionary
		var size: int = dictionary.size()
		var count: int = 0
		if size <= 0:
			string += make_tabs_and_string("{}\n", numof_tab, no_tab_first)
		else:
			string += make_tabs_and_string("{\n", numof_tab, no_tab_first)
			for key in dictionary.keys():
				var value = dictionary[key]
				# タブとキーの部分だけ先に追加します。
				string += make_tabs_and_string("\"%s\": " % [key], numof_tab + 1, false)
				# 最後の要素の末尾には , をつけません。
				# すでにタブとキーを文字列に追加しているので、no_tab_first を true で処理します。
				if count >= (size - 1):
					string = to_pretty_print_string_recursive(value, numof_tab + 1, string, true, true)
				else:
					string = to_pretty_print_string_recursive(value, numof_tab + 1, string, true, false)
				count += 1
			if no_comma_first == true:
				string += make_tabs_and_string("}\n", numof_tab, false)
			else:
				string += make_tabs_and_string("},\n", numof_tab, false)
	elif data is Object: # Object 派生クラスの場合
		var object := data as Object
		# JSON で用いられる ObjectName (ClassName) {\n...\n} の形式で出力します。 
		var name: String = ""
		if "name" in object:
			# name プロパティを持っている場合のみ、名前を表示します。
			name = object.get("name")
		var classname: String = object.get_class()
		string += make_tabs_and_string("%s (%s) {\n" % [name, classname], numof_tab, no_tab_first)
		# ObjectName (ClassName) {\n...\n}  の ... の部分にプロパティリストを出力します。
		var property_list: Array[Dictionary] = object.get_property_list()
		string = to_pretty_print_string_recursive(property_list, numof_tab + 1, string, no_tab_first, no_comma_first)
		if no_comma_first == true:
			string += make_tabs_and_string("}\n", numof_tab, false)
		else:
			string += make_tabs_and_string("},\n", numof_tab, false)
	else:
		# 文字列の場合は "" で括ります。 StringName は & つきの "" で括ります。他は括りません。
		var string_data: String = ""
		if data is String:
			string_data = "\"%s\"" % [str(data)]
		elif data is StringName:
			string_data = "&\"%s\"" % [str(data)]			
		else:
			string_data = str(data)
		# Array でも Dictionary でもない場合は、要素の文字列を追加します。
		# 呼び出し元の no_comma_first に従って、 , の有無で分岐します。
		if no_comma_first == true:
			string += make_tabs_and_string(string_data + "\n", numof_tab + 1, no_tab_first)
		else:
			string += make_tabs_and_string(string_data + ",\n", numof_tab + 1, no_tab_first)
	return string

## [param numof_tab] で指定された数のタブの後に、[param string] で指定された文字列を出力します。
## [param no_tab] が true の場合はタブを追加しません。
static func make_tabs_and_string(string: String, numof_tab: int, no_tab: bool = false) -> String:
	var string_tabs: String = ""
	# タブをつける場合は、指定された回数のタブを追加します。
	if no_tab == false:
		for i in range(numof_tab):
			string_tabs += "\t"
	return string_tabs + string

# ----
# Node
# ----
## 指定したクラスのノードを探します。指定された [param node] が下位のノードを持つ場合は、それも再帰的に探します。
## [param name_of_class] はクラス名の文字列を指定します。
## [param found_nodes] は、条件に合ったノードを追加する配列です。
## 指定したノードまたはその下位のノード群の中に１つでも指定したクラス（またはその派生）のノードがあれば true を、他は false を返します。
static func find_nodes_of_specified_class(node: Node, name_of_class: String, found_nodes: Array[Node]) -> bool:
	var is_one_or_more_matches: bool = false # 戻り値
	if node.is_class(name_of_class):
		#print(name_of_class, " Node found. node = ", node)
		found_nodes.append(node)
		is_one_or_more_matches = true
	for lower_node in node.get_children():
		if find_nodes_of_specified_class(lower_node, name_of_class, found_nodes) == true:
			is_one_or_more_matches = true
	return is_one_or_more_matches

# -----
# Rect2
# -----
## Rect2 の座標とサイズを node のローカル座標からグローバル座標に変換します。
static func to_rect2_to_global(rect2: Rect2, node: Node2D) -> Rect2:
	var global_pos: Vector2 = node.to_global(rect2.position)
	var global_end: Vector2 = node.to_global(rect2.end)
	return Rect2(global_pos, global_end - global_pos)

## Rect2 の座標とサイズをグローバル座標から node のローカル座標に変換します。
static func to_rect2_to_local(rect2: Rect2, node: Node2D) -> Rect2:
	var local_pos: Vector2 = node.to_local(rect2.position)
	var local_end: Vector2 = node.to_local(rect2.end)
	return Rect2(local_pos, local_end - local_pos)

# -----------------
# CollisionObject2D
#------------------
## [b]当たり判定の領域を定義している [Shape2D] 派生リソースを全て取得します。[/b][br]
## [br]
## [CollisionObject2D] の下位ノードが [member CollisionShape2D.Shape] プロパティに持つ [Shape2D] 派生リソースを全て取得します。[br]
static func get_collisionobject2d_shape2d_all(collision_object_2d: CollisionObject2D) -> Array[Shape2D]:
	# 見つかった Shape2D 派生リソースを格納する配列
	var shape2d_array: Array[Shape2D]
	
	# 全てのオーナー ID を配列で取得します。
	var owner_id_array: PackedInt32Array = collision_object_2d.get_shape_owners()
	# オーナーごとに持っている Shape2D 派生リソースを取得します。
	for owner_id in owner_id_array:
		# そのオーナーが持っている Shape2D 派生リソースの個数を取得します。
		var shape_count = collision_object_2d.shape_owner_get_shape_count(owner_id)
		# そのオーナーが持っている Shape2D 派生リソースを１つずつ取得します。
		for shape_index in range(shape_count):
			var shape: Shape2D = collision_object_2d.shape_owner_get_shape(owner_id, shape_index)
			# 取得した Shape2D 派生リソースが有効ならば、戻り値の配列に追加します。
			if shape:
				shape2d_array.append(shape)
	return shape2d_array

# --------
# TileData
# --------
## [b]タイル群の指定したカスタムデータで true と評価されるものが１つ以上あるかどうかを返します。[/b]
## [br]
## [param tiles] から [param custom_key] に対応したカスタムデータを取得して、true と評価されるものが
## 見つかったら true を返し、他は false を返します。
static func has_tiledata_true_custom_data(tiles: Array[TileData], custom_key: String) -> bool:
	for tile in tiles:
		if tile.get_custom_data(custom_key):
			return true
	return false

# ------------
# TileMapLayer
# ------------
## [method SakuraCrowdTileMapLayer.get_entered_tiles] のデバッグ用に、内部処理で扱ったタイルの枠の情報を設定します。
static var tilemaplayer_enable_debug_get_entered_tiles: bool = false

## get_entered_tiles 関数でキャラクターと重なっているタイルのグローバル座標での矩形の配列です。[br]
## _draw 関数などで描画してデバッグ用に使用します。[br]
## [member SakuraCrowdTileMapLayer.enable_debug_get_entered_tiles] が true の場合に
## [method SakuraCrowdTileMapLayer.get_entered_tiles] でデバッグ用のデータを設定します。
static var tilemaplayer_debug_get_entered_tiles_info: Array[Dictionary]

## [b]重なっているタイル群を取得します。[/b][br]
## [br]
## [param body] の当たり判定領域と重なっている [param tilemap_layer] のタイル群を取得します。[br]
## [param body].[member Node2D.global_position] + [param offset] の位置で、 
## [param body] の下位ノードの [member CollsiionShape2D.Shape] プロパティに設定された [Shape2D] 派生リソースすべてと当たり判定をします。[br]
static func get_tilemaplayer_entered_tiles(tilemap_layer: TileMapLayer, body: CollisionObject2D, offset: Vector2 = Vector2.ZERO) -> Array[TileData]:
	# デバッグ用。判定領域のタイルを描画する情報の配列を初期化します。
	if tilemaplayer_enable_debug_get_entered_tiles:
		tilemaplayer_debug_get_entered_tiles_info.clear()

	# 戻り値の変数。body の当たり判定領域と接触したタイルデータの配列です。
	var entered_tiles: Array[TileData]

	# キャラクターの位置を取得
	var body_pos = body.global_position + offset

	# キャラクターの当たり判定領域 (Shape2D 派生リソース) の配列を取得
	var shape_array = get_collisionobject2d_shape2d_all(body)
	#var shape_array: Array[Shape2D]
	if shape_array.size() < 1:
		#print_rich("SakuraCrowdTileMapLayer.get_entered_tiles: \
#[url=https://docs.godotengine.org/ja/4.x/classes/class_shape2d.html]Shape2D[/url]\
# の[color=red][b]リソースがありません。[/b][/color]")
		#print("SakuraCrowdTileMapLayer.get_entered_tiles: Shape2D のリソースがありません")
		#push_error("SakuraCrowdTileMapLayer.get_entered_tiles: Shape2D のリソースがありません")
		push_warning("SakuraCrowdTileMapLayer.get_entered_tiles: Shape2D のリソースがありません")
		return entered_tiles	# 0 個の場合は判定できないので空の配列を返します。

	# 取得した当たり判定領域 (Shape2D 派生リソース）１つずつ、その外接矩形内のタイルと重なりを判定します。
	for shape in shape_array:
		# 当たり判定領域の外接矩形を取得して、body の scale に合わせて拡大縮小します。
		var rect = shape.get_rect()
		rect.position *= body.scale
		rect.size *= body.scale
		
		# デバッグ用に１６の倍数に設定
		#rect.position = Vector2(-8, -8)
		#rect.size = Vector2(16, 16)
		#print("Collision shape rect: ", rect) # Debug

		# タイルの当たり判定用の RectangleShape2D (四角形の Shape2D 派生リソース）をループ前に用意。
		var tile_rect_shape = RectangleShape2D.new()
		tile_rect_shape.size = tilemap_layer.tile_set.tile_size	# タイルのサイズを設定します。
		# 当たり判定の位置（オフセット）を origin メンバ変数で指定する Transform2D 変数をループ前に用意。
		# タイルの当たり判定領域が (0, 0) ~ (tile_size) なので、指定する位置は当たり判定の左上の座標になります。
		var tile_transform2d = Transform2D()

		# グローバル座標の body の当たり判定領域の外接矩形の範囲を、タイルマップのセルの単位に変換します。
		var cell_start_pos = to_tilemaplayer_global_to_cell_pos_floor(rect.position + body_pos, tilemap_layer)
		var cell_end_pos = to_tilemaplayer_global_to_cell_pos_ceil(rect.position + rect.size + body_pos, tilemap_layer)
		#print("Cell start position: ", cell_start_pos) # Debug
		#print("Cell end position: ", cell_end_pos) # Debug

		# body の当たり判定領域の位置（オフセット）を設定します。
		var shape_transform = Transform2D()
		shape_transform.origin = body_pos + rect.position

		# 当たり判定領域の外接矩形内のタイルマップのセルを１つずつ確認します。
		for x in range(cell_start_pos.x, cell_end_pos.x):
			for y in range(cell_start_pos.y, cell_end_pos.y):
				var tile_pos = Vector2(x, y)
				#print("Checking tile position: ", tile_pos) # Debug

				# 調べるタイルの位置（オフセット）を設定します。
				# セルの位置にタイルサイズをかけて、tilemap_layer のオフセットを加味してグローバル座標に変換しています。
				tile_transform2d.origin = tilemap_layer.to_global(tile_pos * tile_rect_shape.size)
				#print("tile_pos = ", tile_pos, ", tile_transform2d.origin = ", tile_transform2d.origin) # Debug

				# タイルの範囲が、 body の当たり判定領域（円や楕円など）に重なっているかを判定します。
				if shape.collide(shape_transform, tile_rect_shape, tile_transform2d):
					# 当たり判定領域に重なっている場所にタイルが配置されていれば、それを戻り値の配列に追加します。
					var tile_data: TileData = tilemap_layer.get_cell_tile_data(tile_pos)
					if tile_data:
						entered_tiles.append(tile_data)
						# デバッグ用。配置されているタイルの範囲を表す矩形情報と、色を指定します。
						if tilemaplayer_enable_debug_get_entered_tiles:
							tilemaplayer_debug_get_entered_tiles_info.append(
								{"rect2": Rect2(tile_transform2d.origin, tile_rect_shape.size),
								"color": Color.CRIMSON})
					else:
						# デバッグ用。タイルはないけれど確認したセルの範囲を表す矩形情報と、色を指定します。
						if tilemaplayer_enable_debug_get_entered_tiles:
							tilemaplayer_debug_get_entered_tiles_info.append(
								{"rect2": Rect2(tile_transform2d.origin, tile_rect_shape.size),
								 "color": Color.AQUA})
	return entered_tiles

## [b]グローバル座標をタイルマップのセルの座標に、小数切り上げで、変換します。[/b][br]
## [br]
## グローバル座標の位置を、tilmepa_layer のセルの位置 (小数切り上げで整数) に変換します。[br]
## [method TileMapLayer.local_to_map](local_pos) + [Vector2i](1, 1) という処理（仮に処理 A）と似ていますが、
## 引数によって処理が異なる場合があります。
## 例えば、[member TileMapLayer.global_posiion] = (0, 0), [member TileMapLayer.tile_set.tile_size] = (16, 16) の場合、
## local_pos が (20, 47) だった場合、本関数では (1, 2) で、処理 A でも (1, 2) と同じ値が返されます。[br]
## しかし、 local_pos が (32, 48) だった場合、本関数では (1, 2) ですが、処理 A では (2, 3) になってしまいます。[br]
static func to_tilemaplayer_global_to_cell_pos_ceil(global_pos: Vector2, tilemap_layer: TileMapLayer) -> Vector2i:
	return Vector2i(to_tilemaplayer_global_to_cell_pos(global_pos, tilemap_layer).ceil())

## [b]グローバル座標をタイルマップのセルの座標に、小数切り捨てで、変換します。[/b][br]
## [br]
## グローバル座標の位置を、[param tilmepa_layer] のセルの位置 (小数切り捨てで整数) に変換します。[br]
## おそらく、[method TileMapLayer.local_to_map] 関数と同じ結果が得られます。[br]
static func to_tilemaplayer_global_to_cell_pos_floor(global_pos: Vector2, tilemap_layer: TileMapLayer) -> Vector2i:
	return Vector2i(to_tilemaplayer_global_to_cell_pos(global_pos, tilemap_layer).floor())

## [b]グローバル座標をタイルマップのセルの座標（小数）に変換します。[/b][br]
## [br]
## グローバル座標の位置を、[param tilmepa_layer] のセルの位置(小数)に変換します。[br]
## [method SakuraCrowdUtil.to_cell_pos_ceil], [method SakuraCrowdUtil.to_ceil_pos_floor] 関数の共通の処理です。[br]
static func to_tilemaplayer_global_to_cell_pos(global_pos: Vector2, tilemap_layer: TileMapLayer) -> Vector2:
	# tilemap_layer のローカル座標に変換。
	# 例えば tilemap_layer.global_position = (-16, 32), global_pos = (64, 80) だった場合
	# local_pos には (64 - (-16), 80 - 32) = (80, 48) に変換されます。 
	var local_pos = tilemap_layer.to_local(global_pos)
	# tilemap_layer のタイル(セル)サイズを取得します。
	var cell_size = Vector2(tilemap_layer.tile_set.tile_size)
	# local_pos = (80, 48) で cell_size = (16, 16) の場合はセル座標 (5, 3) が返されます。
	# セル座標が (4.8, 2.1) のような場合は切り上げられて (5, 3) が返されます。
	return local_pos / cell_size

# -------
# Control
# -------
## [param control] のサイズにフィットするように、 [param text] を描画できる最適なフォントサイズを設定します。
## [param text] が空文字列の場合は何もしません。
## フォントサイズは、 [param control] の Theme Overrides の Font Size で設定します。	
static func fit_control_font_size(control: Control, text: String) -> void:
	var font_size: int = calculate_control_font_size_to_fit(control, text)
	# コントロールからはみでないフォントサイズを設定します。
	# すでに Theme Overrides で設定されている Font Size は上書きされます。
	if font_size > 0:
		if control is RichTextLabel:
			control.add_theme_font_size_override("normal_font_size", font_size)
		else:
			control.add_theme_font_size_override("font_size", font_size)
	return

## [param control] のサイズにフィットするように、 [param text] を描画できる最適なフォントサイズを計算します。
## [param text] が空文字列の場合など、フォントサイズの計算ができなかった場合は 0 を返します。
## [method ScUtil.get_control_content_box_size] でサポートしていないコントロールは対象外です。
static func calculate_control_font_size_to_fit(control: Control, text: String) -> int:
	# 以下のクラスは現在サポート外です。
	if control is RichTextLabel or control is LineEdit or control is TextEdit:
		push_warning(control.get_class() + " は、 Sc Fit Font Size のサポート外です。")
		return 0
		
	# 表示するテキストが空文字列の場合は調整できないので何もしません。
	if text.length() == 0:
		push_warning(str(control) + " にはテキストが入力されていないので調節できません。")
		return 0
	
	# コントロールのサイズを取得します。
	var control_size: Vector2 = get_control_content_box_size(control)
	
	# コントロールの用いるフォントを取得します。
	var font: Font = get_control_font(control)
	
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
		
	return font_size

## まだ調査中です。現状は control.size と同じ値を返します。
## control のサイズから　border, padding 幅を除いた content_box のサイズを得ます。
## Theme の Constants で定義されている場合にその幅を引きます。
## margin, border, padding, content は W3C Box Model を参照してください。
static func get_control_content_box_size(control: Control) -> Vector2:
	# Control のサイズを取得します。
	var content_box_size: Vector2 = control.size
	#if control is RichTextLabel:
		## 水平、垂直の左右・上下のそれぞれの padding 幅を取得します。両側同じ幅になります。
		#var text_highlight_h_padding: int = control.has_theme_constant("text_highlight_h_padding")
		#var text_highlight_v_padding: int = control.has_theme_constant("text_highlight_v_padding")
		#content_box_size.x -= text_highlight_h_padding * 2
		#content_box_size.y -= text_highlight_v_padding * 2
	#if control is LineEdit:
		#pass
	#if control is TextEdit:
		#pass
	
	return content_box_size
	

## [param control] が用いるフォントを取得します。
static func get_control_font(control: Control) -> Font:
	# control が使用しているフォントを取得します。

	# 各 Control 派生クラスのフォントのプロパティ名を取得します。
	var _font_property_name: String = "font"
	if control is RichTextLabel:
		_font_property_name = "normal_font"
	
	# theme から取得する関数の引数には、テーマリソースのフォントに関する項目名 "font" (snake_case)を指定します。
	# 参照：https://docs.godotengine.org/ja/4.x/classes/class_control.html#class-control-method-get-theme-color
	var font: Font = null
	if control.has_theme_font_override("font_property_name") or control.has_theme_font("font_property_name") == true:
		# テーマの font 項目または Control クラス派生のノードが持つ Theme Overrides の font 項目が設定されている場合
		# テーマから font 項目の値(Font)を取得します。
		font = control.get_theme_font("font_property_name") 
	else:
		# フォントが設定されていない場合
		# テーマのデフォルトの font 項目の値(Font)を取得します。
		font = control.get_theme_default_font()
	return font

## [param control] の表示テキストの文字列を返します。
## また、[Control] 以下のクラスを継承した、独自の派生クラスも String 型の text プロパティを持たせることで
## 本関数で表示テキストを取得できます。
##
## 現状は [method ScUtil.get_control_text_from_text_property] と同じです。
## しかし text プロパティ以外から表示テキストを得るクラスが追加された場合は、
## 本関数で、クラス判別、クラス名判別を用いて、拡張する予定です。
## そのため、表示テキストを得る場合は、本関数を使用してください。
##
## Godot 4.3 の Control クラスの派生クラスを確認すると、表示テキストは全て String 型の text プロパティでした。
## 該当クラスは Button, TextEdit, LinkButton, Label, LineEdit, RichTextLabel とその派生クラスです。
## https://docs.godotengine.org/ja/4.3/classes/class_control.html#class-control
static func get_control_text(control: Control) -> String:
	return get_control_text_from_text_property(control)

## [Control] 派生のクラスが text プロパティを持っている場合、その text 文字列を返します。
## これは [Control] 派生の表示するテキストがあるクラスが text という名前のプロパティに設定している特徴を利用するものです。
## また、公式ではない独自の [Control] 派生クラスにも対応する方法としても使えます。
##
## [method ScUtil.get_control_text] は、現状同じ処理ですが、 text プロパティ以外にも対応する関数です。
static func get_control_text_from_text_property(control: Control) -> String:
	#print("control = ", control)
	if control.get("text") != null and control.text is String:
		#print("テキストプロパティを持っています。", control.text)
		# String 型の text プロパティを持っている場合
		return control.text
	#print("テキストプロパティを持っていません。")
	return ""

# -----------
# Performance
# -----------
## Performance.Monitor に登録されている列挙子に関するパフォーマンスの情報を辞書に記録して返します。
## TODO: NAVIGATION_OBSTACLE_COUNT など 4.4 から利用可能な値についてはコメントを解除して使用してください。
static func get_moniter_info() -> Dictionary:
	var monitor_info = {}
	monitor_info["TIME_FPS"] = Performance.get_monitor(Performance.Monitor.TIME_FPS)
	monitor_info["TIME_PROCESS"] = Performance.get_monitor(Performance.Monitor.TIME_PROCESS)
	monitor_info["TIME_PHYSICS_PROCESS"] = Performance.get_monitor(Performance.Monitor.TIME_PHYSICS_PROCESS)
	monitor_info["TIME_NAVIGATION_PROCESS"] = Performance.get_monitor(Performance.Monitor.TIME_NAVIGATION_PROCESS)
	monitor_info["MEMORY_STATIC"] = Performance.get_monitor(Performance.Monitor.MEMORY_STATIC)
	monitor_info["MEMORY_STATIC_MAX"] = Performance.get_monitor(Performance.Monitor.MEMORY_STATIC_MAX)
	monitor_info["MEMORY_MESSAGE_BUFFER_MAX"] = Performance.get_monitor(Performance.Monitor.MEMORY_MESSAGE_BUFFER_MAX)
	monitor_info["OBJECT_COUNT"] = Performance.get_monitor(Performance.Monitor.OBJECT_COUNT)
	monitor_info["OBJECT_RESOURCE_COUNT"] = Performance.get_monitor(Performance.Monitor.OBJECT_RESOURCE_COUNT)
	monitor_info["OBJECT_NODE_COUNT"] = Performance.get_monitor(Performance.Monitor.OBJECT_NODE_COUNT)
	monitor_info["OBJECT_ORPHAN_NODE_COUNT"] = Performance.get_monitor(Performance.Monitor.OBJECT_ORPHAN_NODE_COUNT)
	monitor_info["RENDER_TOTAL_OBJECTS_IN_FRAME"] = Performance.get_monitor(Performance.Monitor.RENDER_TOTAL_OBJECTS_IN_FRAME)
	monitor_info["RENDER_TOTAL_PRIMITIVES_IN_FRAME"] = Performance.get_monitor(Performance.Monitor.RENDER_TOTAL_PRIMITIVES_IN_FRAME)
	monitor_info["RENDER_TOTAL_DRAW_CALLS_IN_FRAME"] = Performance.get_monitor(Performance.Monitor.RENDER_TOTAL_DRAW_CALLS_IN_FRAME)
	monitor_info["RENDER_VIDEO_MEM_USED"] = Performance.get_monitor(Performance.Monitor.RENDER_VIDEO_MEM_USED)
	monitor_info["RENDER_TEXTURE_MEM_USED"] = Performance.get_monitor(Performance.Monitor.RENDER_TEXTURE_MEM_USED)
	monitor_info["RENDER_BUFFER_MEM_USED"] = Performance.get_monitor(Performance.Monitor.RENDER_BUFFER_MEM_USED)
	monitor_info["PHYSICS_2D_ACTIVE_OBJECTS"] = Performance.get_monitor(Performance.Monitor.PHYSICS_2D_ACTIVE_OBJECTS)
	monitor_info["PHYSICS_2D_COLLISION_PAIRS"] = Performance.get_monitor(Performance.Monitor.PHYSICS_2D_COLLISION_PAIRS)
	monitor_info["PHYSICS_2D_ISLAND_COUNT"] = Performance.get_monitor(Performance.Monitor.PHYSICS_2D_ISLAND_COUNT)
	monitor_info["PHYSICS_3D_ACTIVE_OBJECTS"] = Performance.get_monitor(Performance.Monitor.PHYSICS_3D_ACTIVE_OBJECTS)
	monitor_info["PHYSICS_3D_COLLISION_PAIRS"] = Performance.get_monitor(Performance.Monitor.PHYSICS_3D_COLLISION_PAIRS)
	monitor_info["PHYSICS_3D_ISLAND_COUNT"] = Performance.get_monitor(Performance.Monitor.PHYSICS_3D_ISLAND_COUNT)
	monitor_info["AUDIO_OUTPUT_LATENCY"] = Performance.get_monitor(Performance.Monitor.AUDIO_OUTPUT_LATENCY)
	monitor_info["NAVIGATION_ACTIVE_MAPS"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_ACTIVE_MAPS)
	monitor_info["NAVIGATION_REGION_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_REGION_COUNT)
	monitor_info["NAVIGATION_AGENT_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_AGENT_COUNT)
	monitor_info["NAVIGATION_LINK_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_LINK_COUNT)
	monitor_info["NAVIGATION_POLYGON_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_POLYGON_COUNT)
	monitor_info["NAVIGATION_EDGE_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_EDGE_COUNT)
	monitor_info["NAVIGATION_EDGE_MERGE_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_EDGE_MERGE_COUNT)
	monitor_info["NAVIGATION_EDGE_CONNECTION_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_EDGE_CONNECTION_COUNT)
	monitor_info["NAVIGATION_EDGE_FREE_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_EDGE_FREE_COUNT)
	# 4.4 から
	#monitor_info["NAVIGATION_OBSTACLE_COUNT"] = Performance.get_monitor(Performance.Monitor.NAVIGATION_OBSTACLE_COUNT)
	#monitor_info["PIPELINE_COMPILATIONS_CANVAS"] = Performance.get_monitor(Performance.Monitor.PIPELINE_COMPILATIONS_CANVAS)
	#monitor_info["PIPELINE_COMPILATIONS_MESH"] = Performance.get_monitor(Performance.Monitor.PIPELINE_COMPILATIONS_MESH)
	#monitor_info["PIPELINE_COMPILATIONS_SURFACE"] = Performance.get_monitor(Performance.Monitor.PIPELINE_COMPILATIONS_SURFACE)
	#monitor_info["PIPELINE_COMPILATIONS_DRAW"] = Performance.get_monitor(Performance.Monitor.PIPELINE_COMPILATIONS_DRAW)
	#monitor_info["PIPELINE_COMPILATIONS_SPECIALIZATION"] = Performance.get_monitor(Performance.Monitor.PIPELINE_COMPILATIONS_SPECIALIZATION)

	return monitor_info

# -----------
# Inner Class
# -----------
## コンストラクタで渡されたオブジェクトの [method Object.get_signal_list] 関数で得られたシグナルのデータにアクセスしやすくするクラスです。
## RefCounted 派生で参照カウントがなくなると自動的に解放されるので free などの解放関数は呼ばないでください。
## [codeblock]
## extends Control
## func _ready():
##	# Control ノードの持つ全てのシグナルの名前を出力します。
## 	var signal_list_info := ScUtil.SignalListInfo.new(self)
## 	var signal_names: Array[StringName] = []
## 	signal_list_info.get_signal_names(signal_names)
## 	for signal_name in signal_names:
## 		print(signal_name)
## [/codeblock]
class SignalListInfo extends RefCounted:
	# [method Object.get_signal_list] 関数で得たシグナルの情報のリストです。
	var signal_list: Array[Dictionary]
	
	# シグナルの情報を得る対象を [param object] で指定して、本オブジェクトを構築します。
	func _init(object: Object):
		signal_list = object.get_signal_list()
		return
	
	## シグナル情報に含まれている全てのシグナル名を [param signal_names] に追加します。
	func get_signal_names(signal_names: Array):
		ScUtil.get_array_dictionary_specified_key_values(signal_list, "name", signal_names)
		return
	
	## [param signal_name] で指定したシグナルの持つ引数の情報の配列を [param args] に格納します。
	func get_signal_args(signal_name: StringName, args: Array[Dictionary]) -> void:
		# 複数のシグナル情報のリストから、指定した名前のシグナルの情報を取得します。
		var args_array_dictionarys: Array = []
		ScUtil.get_array_dictionary_matched_dictionary(signal_list, "name", signal_name, args_array_dictionarys)
		# 指定した名前を持つシグナルの情報は１つだけ見つかります。
		if args_array_dictionarys.size() != 1:
			push_error("ScSignalListInfo : args_array_dictionarys.size() != 1, size() = " + str(args_array_dictionarys.size()))
			return
		# １つだけの要素を持つ配列から、その要素（辞書）を得ます。
		var args_array_dictionary: Dictionary = args_array_dictionarys[0]
		# シグナルの情報から args の値を取得します。
		if args_array_dictionary.has("args") == false:
			push_error("ScSignalListInfo : args_array_dictionarys.has(\"args\") == false")
			push_warning(ScUtil.to_pretty_print_string(args_array_dictionarys))
			return
		# args キーの値（Array[Dicitionary]) の配列の中にある辞書群を追加します。
		args.append_array(args_array_dictionary.get("args"))
		return
	
	## [param signal_name] で指定したシグナルの持つ引数の個数を返します。
	func get_signal_arg_count(signal_name: StringName) -> int:
		var args: Array[Dictionary]
		get_signal_args(signal_name, args)
		var count: int = args.size()
		return count
	
	## [param signal_name] で指定したシグナルの持つ全ての引数の名前を [param arg_names] に追加します。
	func get_signal_arg_names(signal_name: StringName, arg_names: Array):
		var args: Array[Dictionary]
		get_signal_args(signal_name, args)
		# args の値（辞書の配列）から引数の名前を持つ name キーの値を全て引数の配列 [param arg_names] に格納します。
		ScUtil.get_array_dictionary_specified_key_values(args, "name", arg_names)
		return

## [method Object.get_property_list] で得られる Array[Dictionary] 型のデータから、
## そのオブジェクトが持つプロパティ情報にアクセスしやすくするメンバ関数を持ったクラスです。
class PropertyListInfo extends RefCounted:
	# [method Object.get_property_list] 関数で得たオブジェクトが持つプロパティの情報のリストです。
	var property_list: Array[Dictionary]
	
	# シグナルの情報を得る対象を [param object] で指定して、本オブジェクトを構築します。
	func _init(object: Object):
		property_list = object.get_property_list()
		print(ScUtil.to_pretty_print_string(property_list))
		return
	
	## プロパティ情報に含まれている全てのプロパティ名を [param property_names] に追加します。
	func get_property_names(property_names: Array):
		# プロパティ情報を持つ辞書を複数持つ配列から、各辞書の name キーの値を [param property_names] に追加します。
		ScUtil.get_array_dictionary_specified_key_values(property_list, "name", property_names)
		return
	
	## 指定された型を持つすべてのプロパティ名を [param property_names] に追加します。
	func get_property_names_specified_type(property_names: Array, types: Array[Variant.Type]) -> void:
		# type キーが、[param types] に含まれるいずれかの型番号と同じ、プロパティの Array[Dictionary] を得ます。
		var property_list_specified_type: Array[Dictionary] = []
		ScUtil.get_array_dictionary_matched_dictionary(property_list, "type", types, property_list_specified_type)
		# 得た配列の各プロパティ情報を持つ要素の辞書群から、全ての name キーの値を [param property_names] に追加します。
		ScUtil.get_array_dictionary_specified_key_values(property_list_specified_type, "name", property_names)
		return
	
	## [param property_name] のプロパティ名の変数の型の番号 (Variant.Type) を返します。
	## 該当するプロパティがみつからない、または２個以上見つかった場合はエラーメッセージを出力して TYPE_MAX を返します。
	## 参照：https://docs.godotengine.org/ja/4.x/classes/class_@globalscope.html
	func get_property_type(property_name: StringName) -> Variant.Type:
		# name キーが、[param property_name] と同じ、プロパティの Array[Dictionary] を得ます。
		var property_list_specified_name: Array[Dictionary] = []
		ScUtil.get_array_dictionary_matched_dictionary(property_list, "name", property_name, property_list_specified_name)
		if property_list_specified_name.size() != 1:
			# 指定された名前のプロパティがない場合、または２つ以上ある場合は、無効な引数としてエラーを返します。
			push_error("ScUtil.PropertyListInfo : property_list_specified_name.size() != 1")
			return TYPE_MAX
		# 指定したプロパティ名のプロパティ情報の辞書から type キーの値を得て返します。
		var type := property_list_specified_name[0]["type"] as Variant.Type
		return type

## オブジェクトの持つプロパティ名を全て格納した配列を取得します。
## [param types] で指定した型のプロパティ名に限定します。
## [code] [TYPE_FLOAT, TYPE_INT] [/code] とした場合は float 型と int 型 (Enum を含む) に限定されます。
static func get_object_property_names_specified_types(object: Object, types: Array[Variant.Type]) -> Array[StringName]:
	var property_names: Array[StringName] = []
	if object != null:
		var property_list_info := ScUtil.PropertyListInfo.new(object)
		property_list_info.get_property_names_specified_type(property_names, types)
	return property_names

## オブジェクトの持つシグナル名を全て格納した配列を取得します。
static func get_object_signal_names(object: Object) -> Array[StringName]:
	var signal_names: Array[StringName] = []
	if object != null:
		var signal_list_info := ScUtil.SignalListInfo.new(object)
		signal_list_info.get_signal_names(signal_names)
	return signal_names

# ------------
# OptionButton
# ------------
## [param item_text] で指定したテキストを持つアイテムの要素番号を取得します。	
## 見つかった場合の戻り値の要素番号は 0 ~ ([param option_button].item_count - 1) の範囲の整数です。
## 見つからない場合は -1 を返します。
## 同じテキストのアイテムが複数ある場合は、一番小さい値の要素番号が返されます。
static func get_optionbutton_first_index_from_item_text(option_button: OptionButton, item_text: StringName) -> int:
	for i in range(option_button.item_count):
		var _item_text: StringName = option_button.get_item_text(i)
		if item_text == _item_text:
			return i
	return -1
