#extends EditorInspectorPlugin
#class_name ScMinMaxConstraintHandlerInspector
### ScMinMaxConstraintHandler クラスのインスペクタードックの UI を変更するプラグインです。
#
### property_path_small, property_path_large に割り当てる UI です。
### [EditorInspectorPlugin.add_property_editor] で割り当てる control は
### [EditorProperty] を継承する必要があります。
#class EditorPropertyPropertyPath extends EditorProperty:
	#var node: Node
	#
	## インスペクタードックに表示するコントロールです。
	#var option_button: OptionButton
	#func _init(_node: Node):
		## EditorInspectorPlugih 派生クラスが自身を生成する際に必要なデータは渡してもらい、
		## 後から呼ばれるほかのイベント関数でも使えるようにメンバ変数に格納します。
		#node = _node
		#
		## node の持つ TYPE_FLOAT 型のプロパティ名を配列に追加します。
		#var property_names: Array[StringName] = []
		#if node != null:
			#var property_list_info := ScUtil.PropertyListInfo.new(node)
			#property_list_info.get_property_names_specified_type(property_names, [TYPE_FLOAT, TYPE_INT])
		#
		##set_object_and_property(edited_object, edited_property)
		#
		## _init の時点では、以下の関数は null が得られます。 _update_property では有効になります。
		##print("EditorPropertyPropertyPath._init: get_edited_object() = " + str(get_edited_object()))
		## _init の時点では、以下の関数は "" が得られます。 _update_property では有効になります。
		##print("EditorPropertyPropertyPath._init: get_edited_property() = " + get_edited_property())
		#
		## 配列のプロパティ名を OptionButton の項目として追加します。
		#option_button = OptionButton.new()
		#for property_name in property_names:
			#option_button.add_item(property_name)
		## OptionButton のアイテムが選択された際にメンバ関数を呼び出すようにシグナルと関数を接続します。
		#option_button.item_selected.connect(Callable(self, "_on_option_button_item_selected"))
		#
		## OptionButton をインスペクタードックに表示される EditorProperty に追加します。
		#add_child(option_button)
		#return
	#
	#func _update_property() -> void:
		## EditorInspectorPlugin._parse_property の呼び出し後、 get_edited_object, get_edited_property は有効な値を得られます。
		##print("EditorPropertyPropertyPath._update_property: get_edited_property() = " + get_edited_property())
		##print("EditorPropertyPropertyPath._update_property: get_edited_object() = " + str(get_edited_object()))
		#
		##var sc_min_max_constraint_handler := get_edited_object() as ScMinMaxConstraintHandler
		#
		## 選択されるアイテムの文字列を決定します。
		## 編集対象の ScMinMaxConstraintHandler オブジェクトの対象プロパティの値が優先されます。
		## その値の文字列が "" で未設定の場合は、型ごとにおすすめするプロパティ名を初期値として選択します。
		#var current_property_name: StringName = get_current_property_name()
		#var suggest_property_name: StringName = get_suggest_property_name(node)
		#var select_property_name: StringName = current_property_name
		#if current_property_name == "":
			#select_property_name = suggest_property_name
		#
		## 選択されるアイテムの文字列と同じアイテムを選択します。
		#for i in range(option_button.item_count):
			#var item_text: StringName = option_button.get_item_text(i)
			#if select_property_name == item_text:
				#option_button.select(i)
				#break
		#return
	#
	### option_button のアイテムが選択された際に呼び出されるように設定した関数です。
	### 編集対象のオブジェクトのプロパティの値を変更します。
	#func _on_option_button_item_selected(index: int) -> void:
		#print("_on_option_button_item_selected called. index = " + str(index))
		#set_current_property_name(option_button.get_item_text(index))
		#return
	#
	### 編集対象のオブジェクトの対象のプロパティの値を取得します。
	#func get_current_property_name() -> StringName:
		## 本 UI の編集対象のオブジェクトとプロパティ名からその値を取得します。
		## _init では、まだ有効なオブジェクトとプロパティ名は得られません。
		#var edited_object = get_edited_object()
		#if edited_object == null:
			#push_warning("EditorPropertyPropertyPath.set_current_property_name : edited_object == null")
			#return ""
		#var edited_property = get_edited_property()
		#if edited_object.has(edited_property) == false:
			#push_warning("EditorPropertyPropertyPath.set_current_property_name : edited_object.has(edited_property) == false")
			#return ""
		## 編集対象のオブジェクトのプロパティから値を取得します。
		#var current_property_name = edited_object[edited_property]
		#return current_property_name
	#
	### 編集対象のオブジェクトの対象のプロパティの値に [param property_name] を設定します。
	### [EditorProperty.emit_changed] の仕様に応じて、値が変化した際に [EditorProperty.emit_changed] を呼び出します。
	#func set_current_property_name(property_name: StringName) -> void:
		## 本 UI の編集対象のオブジェクトのプロパティ名の要素にその値を設定します。
		## _init では、まだ有効なオブジェクトとプロパティ名は得られません。
		#var edited_object = get_edited_object()
		#if edited_object == null:
			#push_warning("EditorPropertyPropertyPath.set_current_property_name : edited_object == null")
			#return
		#var edited_property = get_edited_property()
		#if edited_object.has(edited_property) == false:
			#push_warning("EditorPropertyPropertyPath.set_current_property_name : edited_object.has(edited_property) == false")
			#return
		## 編集対象のオブジェクトのプロパティに値を設定します。
		#edited_object[edited_property] = property_name
		#emit_changed(edited_property, property_name)
		#return
	#
	### Node に応じて選択されやすいと思われるプロパティ名を提案します。
	#func get_suggest_property_name(node: Node) -> StringName:
		#if node is Range:
			#return "value"
		#return ""
#
#
#
### [param object] のインスペクタードックが、 UI を変更する対象ならば true を返します。
#func _can_handle(object):
	## We support all objects in this example.
	#if object is ScMinMaxConstraintHandler:
		#return true
	#return false
#
### グループの先頭にコントロールを追加する際に使用します。
#func _parse_group(object: Object, group: String) -> void:
	#if object is ScMinMaxConstraintHandler and group == "MinMaxConstraint":
		#pass
	#return
#
### プロパティ単位でインスペクタードックの UI を変更します。
#func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	#if not object is ScMinMaxConstraintHandler:
		#return false
	#var sc_min_max_constraint_handler := object as ScMinMaxConstraintHandler
	#
	## プロパティ単位で変更するか、既定の UI を使うかを分けます。既定の UI を使う場合は何もせず false を返します。
	#if name == "property_path_small":
		## 最小値を設定するコントロールノードのプロパティ名を指定するプロパティです。
		## 既定の UI の LineEdit ではなく、全ての数値型プロパティの名前を追加したドロップダウンリストを配置します。
		## new (_init) のタイミングで必要な引数を渡し、内部ではメンバ変数として保持して _update_property イベント関数などで用います。
		#var editor_property := EditorPropertyPropertyPath.new(sc_min_max_constraint_handler.node_small)
		## add_property_editor に割り当てる Control は EditorProperty を継承する必要があります。
		## 継承していない OptionButton などを入れると、それだけが表示され、プロパティ名などが表示されません。
		## また add_to_end なども機能しません。
		#add_property_editor(name, editor_property, false, "Property Path Small")
		##add_custom_control(option_button)
		#return true
	#else:
		#return false
