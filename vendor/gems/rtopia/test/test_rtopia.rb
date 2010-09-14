require 'helper'

module RtopiaRuby18
  include Rtopia

  alias to_param to_param_ruby18
end

module String18
  def id
    1001
  end
end

class Person < Struct.new(:name)
  alias to_param name
end

class Entry < Struct.new(:id)
end

class TestRtopia < Test::Unit::TestCase
  include Rtopia

  def setup
    @ruby18 = Object.new
    @ruby18.extend RtopiaRuby18
  end

  def test_R_of_slash_is_slash
    assert_equal '/', R('/')
  end

  def test_R_of_items_is_slash_items
    assert_equal '/items', R(:items)
  end

  def test_R_of_person_named_john_is_john
    assert_equal '/john', R(Person.new('john'))
  end

  def test_R_of_person_named_john_with_items_new_is_john_items_new
    assert_equal '/john/items/new', R(Person.new('john'), :items, :new)
  end

  def test_R_of_items_and_string_1_is_items_1_when_ruby18
    @string_with_id = '1'.extend(String18)

    assert_equal '/items/1', @ruby18.R(:items, @string_with_id)
  end

  def test_R_of_items_and_int_1_is_items_1
    assert_equal '/items/1', @ruby18.R(:items, 1)
  end

  def test_R_of_entries_entry_with_id_10_is_entries_10
    assert_equal '/entries/10', R(:entries, Entry.new(10))
  end

  def test_Rtopia_R_is_calleable_directly
    assert_equal '/items/yeah/boi', Rtopia.R(:items, :yeah, :boi)
  end

  def test_Rtopia_R_with_just_hash_returns_query_string
    assert_equal '?q=Ruby&page=1', Rtopia.R(:q => 'Ruby', :page => 1)
  end

  def test_Rtopia_R_with_search_then_hash_returns_search_with_query_string
    assert_equal '/search?q=Ruby&page=1', R(:search, :q => 'Ruby', :page => 1)
  end

  def test_Rtopia_R_of_array_produces_empty_brackets
    assert_equal '/search?q%5B%5D=first&q%5B%5D=second', 
      R(:search, :q => ['first', 'second'])
  end

  def test_Rtopia_R_of_nested_hash_produces_namespaced_hash
    assert_equal '/users?user%5Blname%5D=Doe&user%5Bfname%5D=John', 
      R(:users, :user => { :lname => 'Doe', :fname => 'John' })
  end

  def test_Rtopia_R_of_string_prefixed_with_slash
    assert_equal '/the-right-path', R('/the-right-path') 
  end

  def test_Rtopia_R_of_string_prefix_with_http
    assert_equal 'http://test.host/arg1/arg2', 
      R('http://test.host', :arg1, :arg2)
  end

  def test_Rtopia_R_of_string_prefix_with_http_and_hash
    assert_equal 'http://test.host/arg1/arg2?key1=value1&key2=value2', 
      R('http://test.host', :arg1, :arg2, :key1 => :value1, :key2 => :value2)
  end

  def test_Rtopia_R_of_string_prefix_with_http_and_hash_and_suffixed
    assert_equal 'http://test.host/arg1/arg2?key1=value1&key2=value2', 
      R('http://test.host/', :arg1, :arg2, :key1 => :value1, :key2 => :value2)
  end
  
  def test_facebook_oauth_example
    assert_equal "https://graph.facebook.com/oauth/authorize?client_id=123",
      R('https://graph.facebook.com/oauth/authorize', :client_id => '123')
  end
end
