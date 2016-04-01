require 'spec_helper'




RSpec.describe MoviesController, :type => :controller do

  describe 'movies with same director happy path' do
    before :each do
      @m=double(Movie, :title => "Star Wars", :director => "director", :id => "1")
      Movie.any_instance.stub(:find).with("1").and_return(@m)
    end

    it 'should go to link with similiar movies' do
      get :moviesWithSameDirector, :find_director => "George Lucas"
      route_to(:controller => "movies", :action => "moviesWithSameDirector", :find_director => "George Lucas")
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
      get :moviesWithSameDirector, :find_director => "George Lucas"

      route_to(:controller => "movies", :action => "moviesWithSameDirector", :find_director => "George Lucas")
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

  describe 'create ' do
    it 'render template' do
      get :new
      response.should render_template 'new'
    end

    it 'persist data' do
      movie =  Movie.any_instance.stub('new movie').as_null_object
      Movie.should_receive(:create!).and_return(movie)

      post :create, {:movie => movie}
    end

  end

  describe 'delete ' do
    it 'render edit template' do
      Movie.any_instance.stub(:find)
      get :edit, {:id => 4}
      response.should render_template 'edit'
    end

    it 'call update data' do
      my_movie = double('movie').as_null_object

      Movie.should_receive(:find).and_return(my_movie)
      my_movie.should_receive(:destroy)

      delete :destroy, {:id => 1}
    end


  end

  describe 'update' do
    it 'updates the movie' do
      put :update, id: 1, movie: { title: 'Star Wars' }
    end

  end

  describe "create" do
    it "table shows" do
      post :create, movie: { title: 'Star Wars' }
    end
  end


  describe "index" do
    it " title" do
      get :index, sort: 'title'
    end

    it "releas date and rating" do
      get :index, sort: 'release_date', ratings: {'R' => 3 }
    end

    it "rating is g" do
      get :index, ratings: {'PG-13' => 2 }
    end

    it " returns table" do
      get :index
    end

  end

  describe "GET show" do
    it "is ok" do
      get :show, id: 1
    end
  end


end