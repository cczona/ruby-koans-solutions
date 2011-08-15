require File.expand_path(File.dirname(__FILE__) + '/edgecase')

class AboutIteration < EdgeCase::Koan

  def test_each_is_a_method_on_arrays
    [].methods.include?("each")
  end

  def test_iterating_with_each
    array = [1, 2, 3]
    sum = 0
    array.each do |item|
      sum += item
    end
    assert_equal 6, sum
  end

  def test_each_can_use_curly_brace_blocks_too
    array = [1, 2, 3]
    sum = 0
    array.each { |item|
      sum += item
    }
    assert_equal 6, sum
  end

  def test_break_works_with_each_style_iterations
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    sum = 0
    array.each { |item|
      break if item > 3
      sum += item
    }
    assert_equal 6, sum
  end

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 }
    assert_equal [11,12,13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11,12,13], another_array
  end

  def test_select_selects_certain_items_from_an_array
    array = [1, 2, 3, 4, 5, 6]

    even_numbers = array.select { |item| (item % 2) == 0 }
    assert_equal [2,4,6], even_numbers

    # NOTE: 'find_all' is another name for the 'select' operation
    more_even_numbers = array.find_all { |item| (item % 2) == 0 }
    assert_equal [2,4,6], more_even_numbers
  end

  def test_find_locates_the_first_element_matching_a_criteria
    array = ["Jim", "Bill", "Clarence", "Doug", "Eli"]

    assert_equal 'Clarence', array.find { |item| item.size > 4 }
  end

  def test_inject_will_blow_your_mind
    result = [2, 3, 4].inject(0) { |sum, item| sum + item }
    assert_equal 9, result

    result2 = [2, 3, 4].inject(1) { |sum, item| sum * item }
    assert_equal 24, result2

    # Extra Credit:
    # Describe in your own words what inject does.
    #CCZ: inject combines the elements of an enumerable collection.  It takes 0, 1, or 2 parameters.  see tests below for more detailed info.
  end
  
  #CCZ
  def test_inject_works_the_way_I_think_it_does
  	# it can take one bare (i.e. not followed by a block) parameter, which must be a symbol for either an operator or a method_name. the first item in the collection will be the starting value for doing the operation specified by that symbol
  	a=[1,2,3]
  	b=a.inject(:+)
  	assert_equal 6, b
  	
  	c=a.inject(:-)
  	assert_equal -4,c
  	
  	d=a.inject(:modulo)
  	assert_equal 1, d
  	
  	a=['a','b','c']
  	e=a.inject(:<<)
  	assert_equal 'abc', e
  	
  	# it can take two bare (i.e. not followed by a block) parameters.  the first parameter specifies the starting value.  the second parameter is a symbol as in above.
  	
  	a=[1,2,3]
  	b=a.inject 10, :-
  	assert_equal 4, b
  
  # it can also take a block, defined as { | accumulation, item| block}.
  # when there is no parameter before the block, the first item in the enumeration is used as the starting value
  a=[2,3,4]
  b=a.inject {|tally, i| tally * i}
  assert_equal 24, b
  
  # or there can be one parameter before the block.  the parameter is used as the starting value
  
  c=a.inject(10) {|tally, i| tally *i}
  assert_equal 240, c
	end

  def test_all_iteration_methods_work_on_any_collection_not_just_arrays
    # Ranges act like a collection
    result = (1..3).map { |item| item + 10 }
    assert_equal [11,12,13], result

    # Files act like a collection of lines
    File.open("example_file.txt") do |file|
      upcase_lines = file.map { |line| line.strip.upcase }
      assert_equal ['THIS', 'IS', 'A', 'TEST'], upcase_lines
    end

    # NOTE: You can create your own collections that work with each,
    # map, select, etc.
  end

  # Bonus Question:  In the previous koan, we saw the construct:
  #
  #   File.open(filename) do |file|
  #     # code to read 'file'
  #   end
  #
  # Why did we do it that way instead of the following?
  #
  #   file = File.open(filename)
  #   # code to read 'file'
  #
  # When you get to the "AboutSandwichCode" koan, recheck your answer.

end
