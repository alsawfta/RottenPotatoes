require 'spec_helper'




RSpec.describe MoviesController, :type => :controller do

  describe 'movies with same director happy path' do
    before :each do
      @m=double(Movie, :title => "Star Wars", :director => "director", :id => "1")
      Movie.any_instance.stub(:find).with("1").and_return(@m)
    end

    it 'should go to link with similiar movies' do
      { :get => "movies/George%20Lucas/moviesWithSameDirector" }.
          should route_to(:controller => "movies", :action => "moviesWithSameDirector", :find_director => "George Lucas")
    end

    it 'should call the model method that finds similar movies' do
      fake_results = [double('Movie'), double('Movie')]
      get :moviesWithSameDirector, :find_director => "George Lucas"
    end


    it 'should use the moviesWithSameDirector view' do
      get :moviesWithSameDirector, :find_director => "George Lucas"
      response.should render_template('moviesWithSameDirector')

    end
  end

  describe 'sad path' do
    before :each do
      m=double(Movie, :title => "Star Wars", :director => " ", :id => "1")
      Movie.any_instance.stub(:find).with("1").and_return(@m)
    end

    it 'should go to link with similiar movies' do
      { :get => "movies/George%20Lucas/moviesWithSameDirector" }.
          should route_to(:controller => "movies", :action => "moviesWithSameDirector", :find_director => "George Lucas")
    end

    it 'should call the model method that finds similar movies' do
      fake_results = [double('Movie'), double('Movie')]
      get :moviesWithSameDirector, :find_director => "George Lucas"
    end


    it 'should use the moviesWithSameDirector view' do
      get :moviesWithSameDirector, :find_director => "George Lucas"
      response.should render_template('moviesWithSameDirector')

    end
  end

  #
  # describe "moviesWithSameDirector" do
  #
  #
  #   # it "returns http success" do
  #   #   get :moviesWithSameDirector
  #   #   expect(response).to have_http_status(302)
  #   # end
  #   #
  #   it "returns movies with the same director" do
  #     director_name = @movies.index(0).director_name
  #     state = false
  #     @movies.each do |movie|
  #       if movie.director_name == director_name
  #         state = true
  #       end
  #     end
  #
  #     expect(state). to be true
  #   end
  #
  #
  #
  #   it "gets all movies with the same director" do
  #     expect(Movie).to receive(:find_director).with("George Lucas") {@fake_results}
  #   end
  #
  #
  # end





end