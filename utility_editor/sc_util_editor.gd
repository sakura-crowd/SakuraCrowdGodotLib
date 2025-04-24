extends Object
class_name ScUtilEditor

## SakuraCrowd が作成した、エディタ上で実行できるユーティリティ関数群です。
## WebGL などにエクスポートした際に、定義されなくなる EditorPlugin クラスなどを用います。
## 本スクリプトは自己責任でご使用ください。
##
## GodotEngine では、そのスクリプトがアタッチされたノードがシーンに追加される際や、グローバルノードが作成される際の他に
## そのスクリプト内に定義されている関数を呼び出す際に、そのスクリプトファイル全体を読み込みます。
## そこで、WebGL などの実行環境で定義されていない EditorPlugin クラスが書かれているとパースエラーが発生して
## そのスクリプト内のすべての関数が使用できなくなります。
## その対策としてエディタ限定の機能を使う関数群は別ファイルに定義します。
##
## もしも、これでも対処できない場合は以下のコードのようにエディタ上かどうかで分岐すると解決するかもしれません。
## [codeblock]
## @tool
## extends EditorPlugin
## func _handles(object: Object) -> bool:
##	if Engine.is_editor_hint():
##		return false
## [/codeblock]
## また動的に gd ファイルを分岐後に load する方法などもフォーラムにあるので参考にしてください。
## 参照：Scripts fail to load with a parse error on exported projects if it uses editor classes · Issue #91713 · godotengine/godot - https://github.com/godotengine/godot/issues/91713
## 
## WebGL でエラーが発生しているかどうかは、 Chrome ならば F12 キーでデベロッパーツールを表示して Console タブを確認してください。

# ------------
# EditorPlugin
# ------------
## [method EditorPlugin._handles] イベント関数がシステムから呼び出されるように促します。
## 方法として、選択中のノードの再選択([method SakuraCrowdUtil.reselect_nodes])、
## 選択されていない場合はルートノードの選択([method SakuraCrowdUtil.add_root_node_to_selection])を行います。
## いずれかの方法を行った場合は true, それ以外は false を返します。
static func request_editorplugin_call_handles_event(editor_plugin: EditorPlugin) -> bool:
	if reselect_editorplugin_nodes(editor_plugin) == false:
		if add_root_node_to_selection(editor_plugin) == false:
			print("SakuraCrowdUtil.request_call_editor_plugin_handles_event: 何も行いませんでした。")
			return false
		else:
			print("SakuraCrowdUtil.request_call_editor_plugin_handles_event: add_root_node_to_selection を行いました。")
	else:
		print("SakuraCrowdUtil.request_call_editor_plugin_handles_event: reselect_nodes を行いました。")
	return true

## 現在選択されているノード群を一度解除してから再び選択します。
## 選択されているノードがない場合はルートノードを再び選択します。
## ルートノードがない場合は何もしません。
## 再選択を行った場合は true, それ以外は false を返します。
static func reselect_editorplugin_nodes(editor_plugin: EditorPlugin) -> bool:
	# すべての選択中のノードの選択を解除して、そのノード群を取得します。
	var deselected_nodes: Array[Node] = deselect_editorplugin_nodes(editor_plugin)
	
	if deselected_nodes.size() > 0:
		# 選択解除したノード群を再選択します。
		for node in deselected_nodes:
			EditorInterface.get_selection().add_node(node)
		print("SakuraCrowdUtil.reselect_nodes: 選択中のノードを再選択しました。")
		return true
	return false

## 選択中のノード群を解除します。
## 解除したノード群の配列を返します。配列の要素数 size() は 0 かもしれません。
static func deselect_editorplugin_nodes(_editor_plugin: EditorPlugin) -> Array[Node]:
	# 選択中のノード群を取得します。
	var selected_nodes: Array = EditorInterface.get_selection().get_selected_nodes()
	
	# 選択中のノードを１つずつ解除します。
	if selected_nodes.size() > 0:
		for node in selected_nodes:
			EditorInterface.get_selection().remove_node(node)
		print("SakuraCrowdUtil.deselect_nodes: 選択中のノードを選択解除しました。")
	
	return selected_nodes

## ルートノードを選択中のノードに追加します。
## 追加した場合は true, それ以外は false を返します。
static func add_root_node_to_selection(editor_plugin: EditorPlugin) -> bool:
	# 選択されているノードがない場合、ルートノードを再選択します。
	var scene_tree: SceneTree = editor_plugin.get_tree()
	var root_node: Node = scene_tree.edited_scene_root
	if root_node:
		EditorInterface.get_selection().add_node(root_node)
		print("SakuraCrowdUtil.add_root_node_to_selection: ルートノードを選択しました。")
		return true
	else:
		print("SakuraCrowdUtil.add_root_node_to_selection: ノードが選択されていませんでしたし、ルートノードもありませんでした。")
	return false

## _handles の引数とおそらく同等のものを別の方法で取得します。
## 注意： _handles の引数は Object クラスですが、ここで得られるのは Node クラスの配列です。
##
## EditorPlugin _handles イベント関数で渡される引数は、複数のノードなどを選択している場合 MultiNodeEdit と呼ばれる
## アクセスできないクラスのオブジェクトが渡されます。（Godot4.3 2025/02/20 現在）
## その対処法として、別の方法で現在選択されている object 群を取得して、その配列を返します。
## 参照： Expose MultiNodeEdit as a scriptable class · Issue #8067 · godotengine/godot-proposals - https://github.com/godotengine/godot-proposals/issues/8067
static func get_editor_plugin_handles_argumnt(_editor_plugin: EditorPlugin) -> Array[Node]:
	var editor_selection: EditorSelection = EditorInterface.get_selection()
	var selected_nodes: Array[Node] = editor_selection.get_selected_nodes()
	return selected_nodes





## property_path_small, property_path_large に割り当てる UI です。
## [EditorInspectorPlugin.add_property_editor] で割り当てる control は
## [EditorProperty] を継承する必要があります。
class EditorPropertyOptionButton extends EditorProperty:
	# アイテム追加済みの OptionButton です。
	var option_button: OptionButton = null
	# おすすめのアイテムテキストです。編集対象のプロパティが無効の際にデフォルトで設定します。
	var suggest_item_text: StringName = ""
	
	## _init の時点では、以下の関数は null が得られます。 _update_property では有効になります。
	#print("EditorPropertyPropertyPath._init: get_edited_object() = " + str(get_edited_object()))
	## _init の時点では、以下の関数は "" が得られます。 _update_property では有効になります。
	#print("EditorPropertyPropertyPath._init: get_edited_property() = " + get_edited_property())
	func _init(_option_button: OptionButton, _suggest_item_text: StringName):
		# EditorInspectorPlugih 派生クラスが自身を生成する際に必要なデータは渡してもらい、
		# 後から呼ばれるほかのイベント関数でも使えるようにメンバ変数に格納します。
		option_button = _option_button
		suggest_item_text = _suggest_item_text
		
		# OptionButton のアイテムが選択された際にメンバ関数を呼び出すようにシグナルと関数を接続します。
		option_button.item_selected.connect(Callable(self, "_on_option_button_item_selected"))
		# OptionButton をもったコンテナをインスペクタードックに表示される EditorProperty に追加します。
		add_child(option_button)
		return
	
	# 編集対象のオブジェクト・プロパティの値で UI を更新します。
	# 編集対象のプロパティの値と一致する OptionButton のアイテムを選択します。
	# EditorInspectorPlugin._parse_property の呼び出し後、 get_edited_object, get_edited_property は有効な値を得られます。
	func _update_property():
		#print("EditorPropertyOptionButton._update_property: get_edited_property() = " + get_edited_property())
		#print("EditorPropertyOptionButton._update_property: get_edited_object() = " + str(get_edited_object()))
		
		# option_button で選択するアイテムの文字列を選択します。
		# 編集対象のプロパティの文字列が有効ならば、それを選択しｍす。
		# 編集対象のプロパティが無効な場合は、おすすめのアイテムテキストを選択します。
		var select_item_text: StringName = ""
		var edited_value := get_edited_value() as StringName
		if edited_value != null and edited_value.length() > 0:
			select_item_text = edited_value
		elif suggest_item_text != null and suggest_item_text.length() > 0:
			select_item_text = suggest_item_text
		
		print("edited_value = " + edited_value)
		print("suggest_item_text = " + suggest_item_text)
		print("select_item_text = " + select_item_text)
		# select_item_text　と同じ　option_button のアイテムを選択します。
		# なければ、未選択の状態にします。
		if select_item_text.length() > 0:
			var select_index: int = ScUtil.get_optionbutton_first_index_from_item_text(option_button, select_item_text)
			# select を実行した後、_on_option_button_item_selected が呼ばれて、編集対象のプロパティもそのアイテムのテキストが設定されます。
			option_button.select(select_index)
		# 有効なアイテムテキストが無効な場合は、未選択 (index == -1) を設定します。
		else:
			option_button.select(-1)
		
		return
	
	## option_button のアイテムが選択された際に呼び出されるように設定した関数です。
	## 編集対象のオブジェクトのプロパティの値を変更します。
	func _on_option_button_item_selected(index: int) -> void:
		#print("EditorPropertyOptionButton._on_option_button_item_selected called. index = " + str(index))
		set_edited_value(option_button.get_item_text(index))
		return
	
	## 編集対象のオブジェクトの対象のプロパティの値を取得します。
	func get_edited_value() -> StringName:
		print("get_edited_value called.")
		# 本 UI の編集対象のオブジェクトとプロパティ名からその値を取得します。
		# _init では、まだ有効なオブジェクトとプロパティ名は得られません。
		var edited_object = get_edited_object()
		if edited_object == null:
			push_warning("EditorPropertyOptionButton.get_editied_value : edited_object == null")
			return ""
		print("get_edited_value called.2")
		var edited_property: StringName = get_edited_property()
		if edited_object.get(edited_property) == null:
			push_warning("EditorPropertyOptionButton.get_editied_value : edited_object.has(edited_property) == false")
			return ""
		print("get_edited_value called.3")
		# 編集対象のオブジェクトのプロパティから値を取得します。
		var edited_value = edited_object[edited_property]
		print("get_edited_value return = " + edited_value)
		return edited_value
	
	## 編集対象のオブジェクトの対象のプロパティの値に [param property_name] を設定します。
	## [EditorProperty.emit_changed] の仕様に応じて、値が変化した際に [EditorProperty.emit_changed] を呼び出します。
	func set_edited_value(edited_value: StringName) -> void:
		print("set_edited_value called. edited_value = " + edited_value)
		# 本 UI の編集対象のオブジェクトのプロパティ名の要素にその値を設定します。
		# _init では、まだ有効なオブジェクトとプロパティ名は得られません。
		var edited_object = get_edited_object()
		if edited_object == null:
			push_warning("EditorPropertyOptionButton.set_edited_value : edited_object == null")
			return
		var edited_property = get_edited_property()
		if edited_object.get(edited_property) == null:
			push_warning("EditorPropertyOptionButton.set_edited_value : edited_object.has(edited_property) == false")
			return
		# 編集対象のオブジェクトのプロパティに値を設定します。
		edited_object[edited_property] = edited_value
		emit_changed(edited_property, edited_value)
		return
	
	## [member suggest_item_text] を設定します。
	func set_suggest_item_text(_suggest_item_text: StringName):
		suggest_item_text = _suggest_item_text
		return
	## [ScMinMaxConstraintHandlerInspector] により、 option_button のアイテム群が変更された際に呼び出される関数です。
	func notify_option_button_items_changed():
		## 選択肢が変わるため、編集対象のプロパティの値を無効化します。
		set_edited_value("")
		return

## ScMinMaxConstraintHandler クラスのインスペクタードックの UI を変更するプラグインです。
class ScMinMaxConstraintHandlerInspector extends EditorInspectorPlugin:
	## [ScUtil.ScMinMaxConstraintHandler.property_path_small] を編集するインスペクタードックの EditorProperty です。
	var property_path_small_editor_property: EditorPropertyOptionButton = null
	## [ScUtil.ScMinMaxConstraintHandler.signal_name_small] を編集するインスペクタードックの EditorProperty です。
	var signal_name_small_editor_property: EditorPropertyOptionButton = null
	## [ScUtil.ScMinMaxConstraintHandler.property_path_large] を編集するインスペクタードックの EditorProperty です。
	var property_path_large_editor_property: EditorPropertyOptionButton = null
	## [ScUtil.ScMinMaxConstraintHandler.signal_name_large] を編集するインスペクタードックの EditorProperty です。
	var signal_name_large_editor_property: EditorPropertyOptionButton = null
	
	## [param object] のインスペクタードックが、 UI を変更する対象ならば true を返します。
	func _can_handle(object):
		# We support all objects in this example.
		if object is ScMinMaxConstraintHandler:
			return true
		return false

	## グループの先頭にコントロールを追加する際に使用します。
	func _parse_group(object: Object, group: String) -> void:
		if object is ScMinMaxConstraintHandler and group == "MinMaxConstraint":
			pass
		return

	## プロパティ単位でインスペクタードックの UI を変更します。
	func _parse_property(object, _type, name, _hint_type, _hint_string, _usage_flags, _wide):
		# 編集対象のオブジェクトが指定の型以外の場合は、こちらで処理せず、デフォルトの UI で処理します。
		var sc_min_max_constraint_handler := object as ScMinMaxConstraintHandler
		if sc_min_max_constraint_handler == null:
			return false
		# プロパティ名で、UI を変更するか、既定の UI を使うかを判別します。
		# UI を差し替える場合は true を返します。
		match(name):
			"property_path_small":
				var node = sc_min_max_constraint_handler.node_small
				var property_names: Array[StringName] = ScUtil.get_object_property_names_specified_types(node, [TYPE_FLOAT, TYPE_INT])
				var suggest_item_text: StringName = get_suggest_property_name(node)
				property_path_small_editor_property = _add_editor_property_option_button(name, property_names, suggest_item_text, "")
				return true
			"property_path_large":
				var node = sc_min_max_constraint_handler.node_large
				var property_names: Array[StringName] = ScUtil.get_object_property_names_specified_types(node, [TYPE_FLOAT, TYPE_INT])
				var suggest_item_text: StringName = get_suggest_property_name(node)
				property_path_large_editor_property = _add_editor_property_option_button(name, property_names, suggest_item_text, "")
				return true
			"signal_name_small":
				var node = sc_min_max_constraint_handler.node_small
				var signal_names: Array[StringName] = ScUtil.get_object_signal_names(node)
				var suggest_item_text: StringName = get_suggest_signal_name(node)
				signal_name_small_editor_property = _add_editor_property_option_button(name, signal_names, suggest_item_text, "")
				return true
			"signal_name_large":
				var node = sc_min_max_constraint_handler.node_large
				var signal_names: Array[StringName] = ScUtil.get_object_signal_names(node)
				var suggest_item_text: StringName = get_suggest_signal_name(node)
				signal_name_large_editor_property = _add_editor_property_option_button(name, signal_names, suggest_item_text, "")
				return true
			_:
				# 差し替え対象以外のプロパティは、ビルトインのデフォルトの UI を使用するため false を返します。
				return false
	
	## object のインスペクタードックの編集領域の最後に UI を追加することができます。
	func _parse_end(object):
		print("_parse_end called.")
		## ScMinMaxConstraintHandler の node_small, node_large メンバ変数が変更された際に発するシグナルをメンバ関数に接続します。
		var sc_min_max_constraint_handler := object as ScMinMaxConstraintHandler
		sc_min_max_constraint_handler.node_small_changed.connect(Callable(self, "_on_node_small_changed"))
		sc_min_max_constraint_handler.node_large_changed.connect(Callable(self, "_on_node_large_changed"))
		return
	
	## OptionButton を持つ EditorProperty を作成する関数です。
	## [param item_text_list] に、選択する項目のテキストを配列で指定します。
	## [param suggest_item_text] は、値が無効の場合に自動的に選択・設定される項目のテキストを指定します。
	## "" や項目にないテキストの場合は選択・設定されません。
	## [param property_name] と [param display_property_name] は [member EditorInspectorPlugin.add_editor_property] に渡す name と label 引数です。
	## [param display_property_name] は "" を渡すことで、 [param property_name] を自動的に変換した名前が表示されます。
	## 戻り値で作成した EditorPropertyOptionButton を返します。
	func _add_editor_property_option_button(property_name: String, item_text_list: Array[StringName], suggest_item_text: StringName, display_property_name: StringName) -> EditorPropertyOptionButton:
		# 指定されたテキスト項目を追加した OptionButton を作成します。
		var option_button = OptionButton.new()
		option_button.fit_to_longest_item = false # 長い項目名に合わせると、左側のプロパティ名にかぶさるため、 false にします。
		for item_text in item_text_list:
			option_button.add_item(item_text)
		
		# おすすめのアイテム項目を選択します。
		# EditorPropertyOptionButton._update_property で、編集対象のプロパティに異なる有効な値があれば、そちらに変更されます。
		var suggest_index: int = ScUtil.get_optionbutton_first_index_from_item_text(option_button, suggest_item_text)
		option_button.select(suggest_index)
	
		# option_button を配置した EdtiorProperty を作成します。
		# 【注意!】add_property_editor に割り当てる Control は EditorProperty を継承する必要があります。
		# 継承していない OptionButton などを入れると、それだけが表示され、プロパティ名などが表示されません。
		# また add_to_end なども機能しません。
		var editor_property = EditorPropertyOptionButton.new(option_button, suggest_item_text)
		# 今回の _parse_property 関数の引数 (object, name) に対応するメンバ変数のプロパティエディタをインスペクタードックに追加します。
		add_property_editor(property_name, editor_property, false, display_property_name)
		
		return editor_property

	## Node に応じて選択されやすいと思われるプロパティ名を提案します。
	## 特になければ "" を返します。
	func get_suggest_property_name(node):
		if node is Range:
			return "value"
		return ""
	
	## Node に応じて選択されやすいと思われるシグナル名を提案します。
	## 特になければ "" を返します。
	func get_suggest_signal_name(node):
		if node is Range:
			return "value_changed"
		return ""
	
	## option_button で表示する項目を持つ [ScMinMaxConstraintHandler.node_small] が変更された際に呼び出されます。
	## [ScMinMaxConstraintHandlerInspector] で、[ScMinMaxConstraintHandler] のシグナルを本関数と接続しています。
	func _on_node_small_changed(node: Node) -> void:
		print("_on_node_small_changed called. node = " + str(node))
		_change_option_button_property_editor(node, property_path_small_editor_property, signal_name_small_editor_property)
		return

	## option_button で表示する項目を持つ [ScMinMaxConstraintHandler.node_small] が変更された際に呼び出されます。
	## [ScMinMaxConstraintHandlerInspector] で、[ScMinMaxConstraintHandler] のシグナルを本関数と接続しています。
	func _on_node_large_changed(node: Node) -> void:
		print("_on_node_large_changed called. node = " + str(node))
		_change_option_button_property_editor(node, property_path_large_editor_property, signal_name_large_editor_property)
		return
	
	## [method _on_node_small_changed] と [method _on_node_large_changed] イベント関数内で呼び出す共通処理です。
	## ノードが変わった際に、そのノードの持つプロパティ・シグナル名に各 OptionButton の項目を変更して、おすすめの項目を変更して、EditorProperty の更新を要求します。
	func _change_option_button_property_editor(node: Node, property_path_editor_property: EditorPropertyOptionButton, signal_name_editor_property: EditorPropertyOptionButton):
		var property_names: Array[StringName] = ScUtil.get_object_property_names_specified_types(node, [TYPE_FLOAT, TYPE_INT])
		var signal_names: Array[StringName] = ScUtil.get_object_signal_names(node)
		var suggest_property_name: StringName = get_suggest_property_name(node)
		var suggest_signal_name: StringName = get_suggest_signal_name(node)
		# すでに配置している OptionButton の選択項目を新しい node の項目に置き換えます。
		property_path_editor_property.option_button.clear()
		signal_name_editor_property.option_button.clear()
		for property_name in property_names:
			property_path_editor_property.option_button.add_item(property_name)
		for signal_name in signal_names:
			signal_name_editor_property.option_button.add_item(signal_name)
		#　おすすめの項目名も新しい選択項目にあるものを設定します。
		property_path_editor_property.set_suggest_item_text(suggest_property_name)
		signal_name_editor_property.set_suggest_item_text(suggest_signal_name)
		# option_button のアイテム群が変わったことを通知して、編集対象の値を無効化します。
		property_path_editor_property.notify_option_button_items_changed()
		signal_name_editor_property.notify_option_button_items_changed()
		# 新しい項目を持つ option_button と、その中の１つの項目をおすすめに設定した状態で、表示を更新します。
		property_path_editor_property.update_property()
		signal_name_editor_property.update_property()
		
		return

#TODO: Node Small に LabelDescription を割り当てると Propety Path Small のエディタプロパティが乱れる。
#TODO: Node Small 変更時に、Property Path, Signal Name を一度無効化（デフォルトの値）にするようにする。
