class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get "/figures/new" do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])

    if !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    end

    if !params["figure"]["title_ids"].nil?
      params["figure"]["title_ids"].each do |i|
        @figure.titles << Title.find(i)
      end
    end

    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
    end

    if !params["figure"]["landmark_ids"].nil?
      params["figure"]["landmark_ids"].each do |i|
        @figure.landmarks << Landmark.find(i.to_i)
      end
    end
    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  patch "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if !params["title"]["name"].empty?
      @figure.titles << Title.create(params[:title])
    end
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    redirect "/figures"
  end

end
