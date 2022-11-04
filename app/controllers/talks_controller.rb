class TalksController < ApplicationController
  def index
    @talks = Talk.all
  end

  def show
    @talk = Talk.find(params[:id])
  end

  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(talk_params)
    
    if @talk.save
      redirect_to @talk
    else
      render :new
    end
  end

  def create_by_csv
    csv_file = talk_params[:file]
    Csv::TalksCreator.new(csv_file).call
    head :ok
  end

  def edit
    @talk = Talk.find(params[:id])
  end

  def update
    @talk = Talk.find(params[:id])

    if @talk.update(talk_params)
      redirect_to @talk
    else
      render :edit
    end
  end

  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy

    redirect_to talks_path
  end

  private

    def talk_params
      params.require(:talk).permit(:name, :initial_time, :track_id, :file)
    end
end
