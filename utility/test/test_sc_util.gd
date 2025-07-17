extends GutTest
## ScUtil クラスで定義されたユーティリティ関数のテストを行います。

## テストケースごとにテスト実行前に呼び出される GUT のイベント関数です。テスト前の共通の処理を書きます。
func before_each():
	pass

## テストケースごとにテスト実行後に呼び出される GUT のイベント関数です。テスト後の共通の処理を書きます。
func after_each():
	pass

# -----
# Array
# -----
## Array 関係の各テストケースの共通の最初の処理です。
func before_each_array_1():
	pass

## Array 関係の各テストケースの共通の最後の処理です。
func after_each_array_1():
	pass

## [method ScUtil.get_array_element_counts] のテスト関数です。
## 重複した要素を含む配列のそれぞれの要素ごとの個数が正しく集計されていることと、ユニークな要素の個数を確認します。
func test_get_array_element_counts_1():
	var array1 := ["A", "B", "C", "C", "C", "A"]
	var element_counts: Dictionary = ScUtil.get_array_element_counts(array1)
	assert_eq(element_counts["A"], 2)
	assert_eq(element_counts["B"], 1)
	assert_eq(element_counts["C"], 3)
	assert_eq(element_counts.keys().size(), 3)
	return

## [method ScUtil.unique_array] のテスト関数です。
## 重複した要素を含む配列から、重複を除いた配列が戻り値として得られることを確認します。
## 戻り値の配列が、重複しない要素の個数を要素数に持つこと。、もとからある要素は存在し、もとからない要素は存在しないことを確認します。
func test_to_unique_array_1():
	var array1 := ["A", "B", "C", "C", "C", "A"]
	var unique_array1: Array = ScUtil.to_unique_array(array1)
	assert_eq(unique_array1.has("A"), true)
	assert_eq(unique_array1.has("B"), true)
	assert_eq(unique_array1.has("C"), true)
	assert_eq(unique_array1.has("D"), false)
	assert_eq(unique_array1.size(), 3)
	return

# ----------
# Dictionary
# ----------
func test_get_array_dictionary_specified_key_values_1():
	var array_dictionary: Array[Dictionary] = [{"name": "piyo", "level": 99}, {"name": "fuga", "level": 39}]
	var names: Array[String] = []
	ScUtil.get_array_dictionary_specified_key_values(array_dictionary, "name", names)
	assert_eq(names.size(), 2)
	assert_eq(names.has("piyo"), true)
	assert_eq(names.has("fuga"), true)
	assert_eq(names.has("hoge"), false)
	return

func test_get_array_dictionary_matched_dictionary_1():
	var array_dictionary: Array[Dictionary] = [{"name": "piyo", "level": 99}, {"name": "fuga", "level": 39}]
	var matched_dictionarys: Array[Dictionary] = []
	ScUtil.get_array_dictionary_matched_dictionary(array_dictionary, "name", "piyo", matched_dictionarys)
	assert_eq(matched_dictionarys.size(), 1)
	assert_eq(matched_dictionarys[0]["name"], "piyo")
	assert_eq(matched_dictionarys[0]["level"], 99)
	return

# --------------------------
# SignalListInfo inner class
# --------------------------
class LeakObject extends Object:
	var leak_object: Object = null
	func _init():
		#leak_object = Object.new()
		pass
	func _notification(what):
		if what == NOTIFICATION_PREDELETE:
			print("LeakObject: what = NOTIFICATION_PREDELETE")
		

func test_assert_no_new_orphans_bad_1():
	var object_count_before: int = Performance.get_monitor(Performance.OBJECT_COUNT)
	var leak_object = LeakObject.new()
	leak_object.free()
	var object_count_after: int = Performance.get_monitor(Performance.OBJECT_COUNT)
	print("object_count before = " + str(object_count_before) + ", after = " + str(object_count_after))
	assert_no_new_orphans()
	return

# ------------
# TileMapLayer
# ------------
## TileMapLayer 型オブジェクトを引数とする複数のテストケースで共通して用いる変数です。
var tilemaplayer = null

## TileMapLayer 関係の各テストケースの共通の最初の処理です。
func before_each_tilemaplayer():
	# テスト対象関数の TileMapLayer 型の引数の作成
	tilemaplayer = TileMapLayer.new()	# オブジェクトを生成します。
	tilemaplayer.tile_set = TileSet.new()	# タイルセットリソースを新規作成して割り当てます。
	tilemaplayer.tile_set.tile_size = Vector2i(16, 16)	# タイルセットのタイル（セル）のサイズを設定します。
	return

## TileMapLayer 関係の各テストケースの共通の最後の処理です。
func after_each_tilemaplayer():
	# 動的に生成した TileMapLayer オブジェクトを破棄します。
	tilemaplayer.free()
	return

## ScUtil.to_tilemaplayer_global_to_cell_pos_ceil 関数の境界値（境界値 ± 0）の単体テストです。
func test_to_cell_pos_ceil_1():
	before_each_tilemaplayer()
	
	# テスト対象関数の Vector2 型の引数の作成
	var global_pos = Vector2(16, 0)	# タイルサイズの境界値 ± 0 の値を設定
	
	# 期待する値を指定します。
	var correct = Vector2i(1, 0)
	# テスト対象関数を呼び出して結果を得ます。
	var result: Vector2i = ScUtil.to_tilemaplayer_global_to_cell_pos_ceil(global_pos, tilemaplayer)
	# GUT の関数で、結果の値と期待する値が同じかどうかをテストします。
	assert_eq(result, correct)
	
	after_each_tilemaplayer()
	return

## ScUtil.to_tilemaplayer_global_to_cell_pos_ceil 関数の境界値（境界値 - 1）の単体テストです。
func test_to_cell_pos_ceil_2():	
	before_each_tilemaplayer()
	
	# テスト対象関数の Vector2 型の引数の作成
	var global_pos = Vector2(15, -1)	# タイルサイズの境界値 - 1 の値を設定
	
	# 期待する値を指定します。
	var correct = Vector2i(1, 0)
	# テスト対象関数を呼び出して結果を得ます。
	var result: Vector2i = ScUtil.to_tilemaplayer_global_to_cell_pos_ceil(global_pos, tilemaplayer)
	# GUT の関数で、結果の値と期待する値が同じかどうかをテストします。
	assert_eq(result, correct)
	
	after_each_tilemaplayer()
	return

## ScUtil.to_tilemaplayer_global_to_cell_pos_ceil 関数の境界値（境界値 + 1）の単体テストです。
func test_to_cell_pos_ceil_3():
	before_each_tilemaplayer()
	
	# テスト対象関数の Vector2 型の引数の作成
	var global_pos = Vector2(17, 1)	# タイルサイズの境界値 + 1 の値を設定
	
	# 期待する値を指定します。
	var correct = Vector2i(2, 1)
	# テスト対象関数を呼び出して結果を得ます。
	var result: Vector2i = ScUtil.to_tilemaplayer_global_to_cell_pos_ceil(global_pos, tilemaplayer)
	# GUT の関数で、結果の値と期待する値が同じかどうかをテストします。
	assert_eq(result, correct)
	
	after_each_tilemaplayer()
	return
