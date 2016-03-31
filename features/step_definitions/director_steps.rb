And  /^I fill in "Director" with "(.*)"$/ do |director_name|
  #fill_in("director_name", :with => director_name)

  element = page.find("#movie_director_name")
  element.set(director_name)
end

# When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#   fill_in(field, :with => value)
# end


Given /^the following movies exist:$/ do |table|
  data = table.hashes
  title = []
  data.each do |row|
    row.each do |key, value|
      title << value if key == 'title'
    end
  end

  check = false

  title.each do |movie_name|
    if Movie.find_by_title(movie_name)
      check = true
    end
  end
  assert_equal check, true
end


When /^I go to the edit page for "(.*)"$/ do |movie_name|
  id = Movie.find_by_title(movie_name).id
  visit "/movies/#{id}/edit"
end


Then /^the director of "(.*)" should be "(.*)"$/ do |movie_name, director_name|
  assert_equal Movie.find_by_title(movie_name).director_name, director_name
end


Given /^I am on the details page for "(.*)"$/ do |movie_name|
  id = Movie.find_by_title(movie_name).id
  visit "/movies/#{id}"
end

Then  /^I should be on moviesWithSameDirector page for "(.*)"$/ do |movie_name|
  director = Movie.find_by_title(movie_name).director_name
  if director.nil?
    visit "/movies/"
  else
    director.gsub!(' ', '%20')
    visit "/movies/#{director}/moviesWithSameDirector"
  end
end

Then  /^I should be on the home page$/ do
  current_path = URI.parse(current_url).path
  assert_equal '/movies/%20/moviesWithSameDirector', current_path

end

And /^I should see '(.*)' has no director info$/ do |movie_name|
  director = Movie.find_by_title(movie_name).director_name
  assert_equal director, ' '
end